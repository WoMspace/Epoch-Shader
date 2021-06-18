#version 120

#extension GL_ARB_shader_texture_lod : enable

/*
==== COMPOSITE1:BLOOM #1 ====
- Bloom pass 1
*/

#include "lib/settings.glsl"
#define GAUSSIAN_HORIZONTAL

const int RGBA16F = 0;

uniform sampler2D colortex4;
uniform mat4 gbufferProjection;
uniform float viewWidth;
uniform float viewHeight;

varying vec2 texcoord;

#include "lib/blurs.glsl"

void main()
{
	vec3 color = gaussianBloom(colortex4, texcoord);

	/* DRAWBUFFERS:4 */
	gl_FragData[0] = vec4(color, 1.0);
}