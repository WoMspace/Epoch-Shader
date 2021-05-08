#version 120

#extension GL_ARB_shader_texture_lod : enable

/*
==== COMPOSITE1:CAMERA ====
- DoF
- Bloom
- Grain
- Chroma Sampling
- Film Mode
- Interlacing
*/

#include "lib/settings.glsl"

uniform sampler2D colortex0;
uniform sampler2D noisetex;
uniform sampler2D colortex1;
uniform sampler2D depthtex0;
uniform mat4 gbufferProjection;
uniform mat4 gbufferProjectionInverse;
uniform float centerDepthSmooth;
uniform float far;
uniform float near;
uniform float viewWidth;
uniform float viewHeight;
uniform float aspectRatio;
uniform int frameCounter;
uniform float frameTimeCounter;

const bool colortex1Clear = false;
const bool colortex0MipmapEnabled = true;

varying vec2 texcoord;

#include "lib/depth.glsl"
#include "lib/maths.glsl"
#include "lib/blurs.glsl"
#include "lib/color.glsl"

void main()
{
	vec3 color = texture2D(colortex0, texcoord).rgb;

	#if DOF_MODE == 1 //mip blur
	color = mipBlur(sqrt(abs(getFragDepth(depthtex0, texcoord) - getCursorDepth())));
	#elif DOF_MODE == 2 //bokeh blur
	float coc = texture2DLod(colortex0, texcoord, 3.5).a;
	color = bokehBlur(coc * 10.0);
	#endif

	#ifdef BLOOM_ENABLED

		vec3 bloomColor = color;// * 10.0 - 7.5;
		int count = 0;
		for(float i = 0.0; i < 7.0; i += 0.1)
		{//kinda sketch ngl. WIP.
			bloomColor += texture2DLod(colortex0, texcoord, i).rgb * 10.0 - 7.5;
			count++;
		}
		//bloomColor = bloomColor * 10.0 - 7.5;
		color =+ clamp(bloomColor / count, 0.0, 2.0);
	#endif

	#if FILM_MODE != 0
		#if FILM_MODE == 1 // greyscale
			color = extractLuma(color, vec3(GREYSCALE_RED_CONTRIBUTION, GREYSCALE_GREEN_CONTRIBUTION, GREYSCALE_BLUE_CONTRIBUTION));
			color = contrast(color, FILM_BRIGHTNESS, FILM_CONTRAST);
		#elif FILM_MODE == 2 // color film
			color = colorFilm(color, 1.0);
		#endif
	#endif

	#if GRAIN_MODE != 0
		float noiseSeed = float(frameCounter) * 0.11;
		vec2 noiseCoord = texcoord + vec2(sin(noiseSeed), cos(noiseSeed));

		#if GRAIN_MODE == 1 // luma noise
		color += vec3(texture2D(noisetex, noiseCoord).r - 0.5)*GRAIN_STRENGTH;
		#elif GRAIN_MODE == 2 // chroma noise
		color += (texture2D(noisetex, noiseCoord).rgb - vec3(0.5))*GRAIN_STRENGTH;
		#endif
	#endif

	#ifdef CHROMA_SAMPLING_ENABLED
		vec3 chroma = normalize(texture2DLod(colortex0, texcoord, CHROMA_SAMPLING_SIZE).rgb) * 2.0;
		color = chroma * extractLuma(color);
	#endif

	#ifdef QUANTISATION_ENABLED
	color *= quantisation_colors_perchannel;
	color = round(color);
	color *= 1.0 / quantisation_colors_perchannel;
	#endif

	vec3 color2 = color;
	#ifdef INTERLACING_ENABLED
	if(mod(gl_FragCoord.y, INTERLACING_SIZE) > (INTERLACING_SIZE - 1.0)*0.5)
		{
			color = texture2D(colortex1, texcoord).rgb;
		}
	#endif

	float spotLoc = 0.0;
	#ifdef FILM_IMPERFECTIONS_SPOTS_ENABLED
		//preparation for next pass
		float threshold = 1.0 - (FILM_IMPERFECTIONS_SPOTS_AMOUNT * 0.01);
		spotLoc = clamp(texture2D(noisetex, noiseCoord).r - threshold, 0.0, 0.01) * (1.0 / FILM_IMPERFECTIONS_SPOTS_AMOUNT) * 100.0;
	#endif

	/* DRAWBUFFERS:01 */
	gl_FragData[0] = vec4(color, spotLoc); //alpha has film grunge spot locations
	gl_FragData[1] = vec4(color2, texture2D(colortex1, texcoord).a);
}