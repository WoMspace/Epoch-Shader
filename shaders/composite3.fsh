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
#if DITHERING_MODE == DITHERING_BLUE || GRAIN_MODE != 0
uniform sampler2D depthtex1;
#endif

varying vec2 texcoord;

#include "lib/depth.glsl"
#include "lib/maths.glsl"
#include "lib/blurs.glsl"
#include "lib/color.glsl"

void main()
{
	float z = texture2D(depthtex0, texcoord).r;
	vec3 color;

	if(z > 0.56) 
	{
		#if DOF_MODE == 1 	//mip blur
		color = mipBlur(sqrt(abs(getFragDepth(depthtex0, texcoord) - getCursorDepth())), colortex0);
		#elif DOF_MODE == 2 	//bokeh blur
		float coc = texture2DLod(colortex0, texcoord, 3.5).a;
		color = bokehBlur(coc * 10.0, colortex0);
		#endif
	}
	else 
	{
		color = texture2D(colortex0, texcoord).rgb;
	}

	#if FILM_MODE != 0
		#if FILM_MODE == 1 // greyscale
			color = extractLuma(color, vec3(GREYSCALE_RED_CONTRIBUTION, GREYSCALE_GREEN_CONTRIBUTION, GREYSCALE_BLUE_CONTRIBUTION));
			color = contrast(color, FILM_BRIGHTNESS, FILM_CONTRAST);
		#elif FILM_MODE == 2 // color film
			color = colorFilm(color, 1.0);
			color = -e(-color * 2.0) + 1.0; // something-something-highlight falloff
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

	#if GRAIN_MODE != 0 || defined(FILM_IMPERFECTIONS_SPOTS_ENABLED)
		float noiseSeed = float(frameCounter) * 0.11;
		vec2 noiseCoord = texcoord + vec2(sin(noiseSeed), cos(noiseSeed));
	#endif
	#if GRAIN_MODE != 0
		float grain_strength = GRAIN_STRENGTH * (1.0 - length(color)) * (GRAIN_PERFORMANCE * GRAIN_PERFORMANCE * 0.5);
		#if GRAIN_MODE == 1 // luma noise
		color += vec3(texture2D(noisetex, noiseCoord).r + texture2D(depthtex1, noiseCoord).a - 1.0) * grain_strength;
		#elif GRAIN_MODE == 2 // chroma noise
		color += (texture2D(noisetex, noiseCoord).rgb + texture2D(depthtex1, noiseCoord).rgb - vec3(1.0)) * grain_strength;
		#endif
	#endif

	#if CHROMA_SAMPLING_MODE == CHROMA_SAMPLING_DOWNSAMPLE
		vec3 chroma = normalize(texture2DLod(colortex0, texcoord, CHROMA_SAMPLING_SIZE).rgb) * 2.0;
		color = max(chroma * extractLuma(color), 0.0);
	#elif CHROMA_SAMPLING_MODE == CHROMA_SAMPLING_SHIFT
		vec3 chroma = normalize(texture2DLod(colortex0, texcoord - vec2(7.0 / viewWidth, 0.0), CHROMA_SAMPLING_SIZE).rgb) * 2.0;
		color = max(chroma * extractLuma(color), 0.0);
	#endif

	#if DITHERING_MODE == DITHERING_BAYER
	color += (bayer128(gl_FragCoord.xy) * DITHERING_STRENGTH) / quantisation_colors_perchannel;
	#elif DITHERING_MODE == DITHERING_BLUE
	vec2 ditherUV = vec2(texcoord.x * (viewWidth / 1024.0), texcoord.y * (viewHeight / 1024.0));
	color += (texture2D(depthtex1, ditherUV).a * DITHERING_STRENGTH) / quantisation_colors_perchannel;
	#endif
	#ifdef QUANTISATION_ENABLED
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
