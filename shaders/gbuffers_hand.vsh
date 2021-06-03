#version 120

#define VSH

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowProjection;
uniform mat4 shadowModelView;
varying vec4 shadowPos;
#include "lib/settings.glsl"
#include "lib/shadows.glsl"

void main() {
	gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
	shadowPos = calculateShadowUV();
}