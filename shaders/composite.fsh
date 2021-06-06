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
#include "lib/color.glsl"

void main()
{
	vec3 color = texture2D(colortex0, texcoord).rgb;

	#ifdef SHADER_FOG_ENABLED
	color = doFog(getRoundFragDepth(depthtex0, texcoord), color);
	#endif

	float coc = 1.0;
	#if DOF_MODE == DOF_BOKEH
		float fragDepth = getFragDepth(depthtex0, texcoord);
		float cursorDepth = getCursorDepth();
		coc = abs(lens_aperture_diameter * ((LENS_LENGTH * (cursorDepth - fragDepth)) / (fragDepth * (cursorDepth - LENS_LENGTH)))) * 0.5;
	#endif

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, coc);
}