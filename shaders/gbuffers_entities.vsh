#version 120

#define VSH

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying mat3 tbn;
attribute vec4 at_tangent;
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
	vec3 normal = gl_NormalMatrix * gl_Normal;
	vec3 tangent = normalize(gl_NormalMatrix * at_tangent.xyz);
	tbn = mat3(tangent, cross(tangent, normal) * sign(at_tangent.w), normal);
	/* tbn = mat3(
    	normalize(gl_NormalMatrix * at_tangent.xyz),
    	normalize(gl_NormalMatrix * cross(at_tangent.xyz, gl_Normal.xyz) * sign(at_tangent.w)),
    	normalize(gl_NormalMatrix * gl_Normal)
    ); */
	shadowPos = calculateShadowUV();
}