#version 120

//#include "settings.glsl"

uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor * 3.0;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}