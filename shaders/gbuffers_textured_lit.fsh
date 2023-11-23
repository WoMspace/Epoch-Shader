#version 120

uniform sampler2D lightmap;
uniform sampler2D texture;
uniform int dimension;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color *= texture2D(lightmap, lmcoord);

	// darken particles in the nether
	if(dimension == -1) {
		color.rgb *= 0.05;
	}

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}