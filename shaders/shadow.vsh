#version 120

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
uniform mat4 shadowModelViewInverse;
uniform vec3 cameraPosition;
uniform float frameTimeCounter;
uniform mat4 shadowModelView;

attribute vec4 mc_Entity;

#include "lib/settings.glsl"
#include "lib/shadows.glsl"

void main() {
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;

		vec3 shadowViewPos = (gl_ModelViewMatrix * gl_Vertex).xyz;
		vec3 playerPos = mat3(shadowModelViewInverse) * shadowViewPos;
		vec3 worldPosition = playerPos + cameraPosition;

	#ifdef VERTEX_WAVING_WATER
	if(mc_Entity.x == 1010)
	{
		vec3 vertOffset = vec3(0.0);
		vertOffset.y += sin(frameTimeCounter + worldPosition.x * 0.5);
		vertOffset.y += sin(frameTimeCounter + worldPosition.z * 0.5);
		vertOffset.y += sin(frameTimeCounter * 5.0 + worldPosition.x * 5.0) * 0.5;
		vertOffset.y += cos(frameTimeCounter * 5.0 + worldPosition.z * 5.0) * 0.5;
		vertOffset.y = vertOffset.y * 0.2 - 0.3;
		worldPosition += vertOffset;
	}
	#endif

	vec3 playerSpace = worldPosition - cameraPosition;
	vec3 shadowViewSpace = mat3(shadowModelView) * playerSpace;
	vec4 clipSpace = gl_ProjectionMatrix * vec4(shadowViewSpace, 1.0);

	gl_Position = clipSpace;

	gl_Position.xy = distort(gl_Position.xy);
}