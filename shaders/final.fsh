#version 120

#include "lib/settings.glsl"

uniform sampler2D colortex0;
varying vec2 texcoord;
uniform sampler2D depthtex0;
uniform float far;
uniform float centerDepthSmooth;
uniform mat4 gbufferProjectionInverse;

#include "lib/depth.glsl"

void main()
{
	float depth = getFragDepth(depthtex0, texcoord);
	vec2 redOffset = vec2(1.0 - (depth / far), 0.0) * 0.05 * ANAGLYPH_3D_SEPARATION;
	vec2 cyanOffset = vec2(-redOffset.x, 0.0);
	vec3 color;
	#ifdef ANAGLYPH_3D_ENABLED
	color.r = texture2D(colortex0, texcoord + redOffset).r;
	color.gb = texture2D(colortex0, texcoord + cyanOffset).gb;
	#else
	color = texture2D(colortex0, texcoord).rgb;
	#endif

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0);
}