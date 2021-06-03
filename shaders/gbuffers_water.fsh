#version 120

#define FSH

#include "lib/settings.glsl"
#include "lib/tonemapping.glsl"

uniform sampler2D lightmap;
uniform sampler2D texture;
uniform vec3 skyColor;
uniform int worldTime;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color.a *= 1.25;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}