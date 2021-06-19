#version 120

#include "lib/settings.glsl"
#include "lib/tonemapping.glsl"

uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color.rgb = srgbToLinear(color.rgb);

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}