#version 120

/*
==== COMPOSITE0:WORLD ====
- Fog
- DoF CoC calculation (hehe coc)
*/

#include "lib/settings.glsl"

const int RGBA16F = 0;

uniform sampler2D colortex0;
const int colortex0Format = RGBA16F;
const bool colortex0MipmapEnabled = true;
uniform sampler2D colortex1;
const int colortex1Format = RGBA16F;
const bool colortex1Clear = false;
uniform sampler2D depthtex0;
uniform mat4 gbufferProjection;
uniform mat4 gbufferProjectionInverse;
uniform float far;
uniform float centerDepthSmooth;
uniform int isEyeInWater;
uniform vec3 fogColor;
uniform float frameTime;
uniform float viewWidth;
uniform float viewHeight;

varying vec2 texcoord;

#include "lib/depth.glsl"
#include "lib/fog.glsl"
#include "lib/tonemapping.glsl"
#include "lib/blurs.glsl"

void main()
{
	vec3 color = texture2D(colortex0, texcoord).rgb;
	//color = linearToSRGB(color * HDR_EXPOSURE_VALUE);
	vec3 exposureSamples = texture2DLod(colortex0, vec2(0.5), 8.0).rgb;
	//exposureSamples += texture2DLod(colortex0, vec2(0.5), 5.0).rgb;
	exposureSamples += texture2DLod(colortex0, vec2(0.5), 10.0).rgb;
	exposureSamples /= 2.0;
	float screenLuminance = dot(vec3(1.0), exposureSamples) * HDR_EXPOSURE_VALUE;
	float temporalLuminance = texture2D(colortex1, vec2(0.5)).a;
	temporalLuminance = mix(temporalLuminance, screenLuminance, frameTime * 3.0);
	float screenExposure = 1.0 / temporalLuminance;
	color = hejlBurgess(color * screenExposure * 0.35);
	//color = linearToSRGB(color);

	#ifdef SHADER_FOG_ENABLED
	color = doFog(getRoundFragDepth(depthtex0, texcoord), color);
	#endif

	float coc = 1.0;
	#if DOF_MODE == DOF_BOKEH
		float fragDepth = getFragDepth(depthtex0, texcoord);
		float cursorDepth = getCursorDepth();
		coc = abs(lens_aperture_diameter * ((LENS_LENGTH * (cursorDepth - fragDepth)) / (fragDepth * (cursorDepth - LENS_LENGTH)))) * 0.5;
	#endif

	vec3 color1 = texture2D(colortex1, texcoord).rgb;

	/* DRAWBUFFERS:01 */
	gl_FragData[0] = vec4(color, coc);
	gl_FragData[1] = vec4(color1, temporalLuminance);
}