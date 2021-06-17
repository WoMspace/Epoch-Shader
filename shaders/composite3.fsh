#version 120

#extension GL_ARB_shader_texture_lod : enable

/*
==== COMPOSITE3:CAMERA #1 ====
- DoF
- Bloom
- Grain
- Chroma Sampling
- Quantisation
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

#if BLOOM_QUALITY != BLOOM_DISABLED
uniform sampler2D colortex4;
#endif

const bool colortex1Clear = false;
const bool colortex0MipmapEnabled = true;

#if FILM_MODE == FILM_THERMAL
uniform sampler2D colortex2;
const bool colortex2MipmapEnabled = true;
#endif
#if DITHERING_MODE == DITHERING_BLUE
uniform sampler2D depthtex1;
#endif

varying vec2 texcoord;

#include "lib/depth.glsl"
#include "lib/maths.glsl"
#include "lib/blurs.glsl"
#include "lib/color.glsl"

void main()
{
	#if DOF_MODE == 1 //mip blur
	vec3 color = mipBlur(sqrt(abs(getFragDepth(depthtex0, texcoord) - getCursorDepth())), colortex0);
	#elif DOF_MODE == 2 //bokeh blur
	float coc = texture2DLod(colortex0, texcoord, 3.5).a;
	vec3 color = bokehBlur(coc * 10.0, colortex0);
	#else
	vec3 color = texture2D(colortex0, texcoord).rgb;
	#endif

	#if FILM_MODE != 0
		#if FILM_MODE == 1 // greyscale
			color = extractLuma(color, vec3(GREYSCALE_RED_CONTRIBUTION, GREYSCALE_GREEN_CONTRIBUTION, GREYSCALE_BLUE_CONTRIBUTION));
			color = contrast(color, FILM_BRIGHTNESS, FILM_CONTRAST);
		#elif FILM_MODE == 2 // color film
			color = colorFilm(color, 1.0);
		#elif FILM_MODE == 3 //thermal
			vec3 cold = vec3(0.1, 0.0, 0.5);
			vec3 hot = vec3(1.0, 0.7, 0.5);
			float temperature = texture2DLod(colortex2, texcoord, 3.0).a;
			color = mix(cold, hot, temperature);
		#endif
	#endif

	#if BLOOM_QUALITY != BLOOM_DISABLED
	color += texture2D(colortex4, texcoord).rgb * BLOOM_STRENGTH;
	#endif

	#if GRAIN_MODE != 0
		float noiseSeed = float(frameCounter) * 0.11;
		vec2 noiseCoord = texcoord + vec2(sin(noiseSeed), cos(noiseSeed));
		float grain_strength = GRAIN_STRENGTH * (1.0 - length(color)) * GRAIN_PERFORMANCE;
		#if GRAIN_MODE == 1 // luma noise
		color += vec3(texture2D(noisetex, noiseCoord).r - 0.5) * grain_strength;
		#elif GRAIN_MODE == 2 // chroma noise
		color += (texture2D(noisetex, noiseCoord).rgb - vec3(0.5)) * grain_strength;
		#endif
	#endif

	#ifdef CHROMA_SAMPLING_ENABLED
		vec3 chroma = normalize(texture2DLod(colortex0, texcoord, CHROMA_SAMPLING_SIZE).rgb) * 2.0;
		color = max(chroma * extractLuma(color), 0.0);
	#endif

	#ifdef QUANTISATION_ENABLED
	#if DITHERING_MODE == DITHERING_BAYER
	color += bayer128(gl_FragCoord.xy) / quantisation_colors_perchannel;
	#elif DITHERING_MODE == DITHERING_BLUE
	vec2 ditherUV = vec2(texcoord.x * (viewWidth/512), texcoord.y * (viewHeight/512));
	color += texture2D(depthtex1, ditherUV).rgb / quantisation_colors_perchannel;
	#endif
	color *= quantisation_colors_perchannel;
	color = floor(color + 0.5);
	color *= 1.0 / quantisation_colors_perchannel;
	#endif

	float spotLoc = 0.0;
	#ifdef FILM_IMPERFECTIONS_SPOTS_ENABLED
		//preparation for next pass
		float threshold = 1.0 - (FILM_IMPERFECTIONS_SPOTS_AMOUNT * 0.01);
		spotLoc = clamp(texture2D(noisetex, noiseCoord).r - threshold, 0.0, 0.01) * (1.0 / FILM_IMPERFECTIONS_SPOTS_AMOUNT) * 100.0;
	#endif

	vec3 color2 = color;
	#ifdef INTERLACING_ENABLED
	if(mod(gl_FragCoord.y, INTERLACING_SIZE) > (INTERLACING_SIZE - 1.0)*0.5)
		{
			color = texture2D(colortex1, texcoord).rgb;
		}
	#endif

	/* DRAWBUFFERS:01 */
	gl_FragData[0] = vec4(color, spotLoc); //alpha has film grunge spot locations
	gl_FragData[1] = vec4(color2, texture2D(colortex1, texcoord).a);
}