#version 120

attribute vec4 mc_Entity;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

#include "lib/settings.glsl"
#include "lib/shadows.glsl"

void main() {
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;

	#ifdef EXCLUDE_FOLIAGE
		if (mc_Entity.x == 10000.0) {
			gl_Position = vec4(10.0);
		}
		else {
	#endif
			gl_Position = ftransform();
			gl_Position.xy = distort(gl_Position.xy);
	#ifdef EXCLUDE_FOLIAGE
		}
	#endif
}