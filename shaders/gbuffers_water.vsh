#version 120

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying vec4 shadowPos;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferModelView;
uniform mat4 shadowProjection;
uniform mat4 shadowModelView;
uniform mat4 gbufferProjection;

uniform vec3 cameraPosition;
uniform float frameTimeCounter;
uniform sampler2D depthtex0;

attribute vec4 at_tangent;
attribute vec4 mc_Entity;
varying mat3 tbn;

#include "lib/settings.glsl"
#include "lib/shadows.glsl"

void main()
{
	gl_Position = ftransform();
	#ifdef VERTEX_WAVING_WATER
	if(mc_Entity.x == 1010)
	{
		vec3 viewPos = (gl_ModelViewMatrix * gl_Vertex).xyz;
		vec3 eyePlayerPos = mat3(gbufferModelViewInverse) * viewPos;
		vec3 worldPosition = eyePlayerPos + cameraPosition;

		vec3 vertOffset = vec3(0.0);
		vertOffset.y += sin(frameTimeCounter + worldPosition.x * 0.5);
		vertOffset.y += sin(frameTimeCounter + worldPosition.z * 0.5);
		vertOffset.y += sin(frameTimeCounter * 5.0 + worldPosition.x * 5.0) * 0.5;
		vertOffset.y += cos(frameTimeCounter * 5.0 + worldPosition.z * 5.0) * 0.5;
		vertOffset.y = vertOffset.y * 0.2 - 0.3;

		worldPosition += vertOffset;
		vec3 playerSpace = worldPosition - cameraPosition;
		vec3 viewSpace = mat3(gbufferModelView) * playerSpace;
		vec4 clipSpace = gbufferProjection * vec4(viewSpace, 1.0);

		gl_Position += clipSpace;
	}
	#endif


	vec3 normal = gl_NormalMatrix * gl_Normal;
	vec3 tangent = normalize(gl_NormalMatrix * at_tangent.xyz);
	tbn = mat3(tangent, cross(tangent, normal) * sign(at_tangent.w), normal);
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
	shadowPos = calculateShadowUV();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}