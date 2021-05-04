#version 120

#include "lib/settings.glsl"
#include "lib/labPBR.glsl"

uniform sampler2D lightmap;
uniform sampler2D texture;

#ifdef NORMALMAP_ENABLED
uniform sampler2D normals;
#endif
#ifdef SPECULARMAP_ENABLED
uniform sampler2D specular;
#endif


uniform mat4 gbufferModelViewInverse;
uniform vec3 sunPosition;
const float sunPathRotation = -25.0;
uniform int worldTime;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying mat3 tbn;


void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color *= texture2D(lightmap, lmcoord);
	#ifdef NORMALMAP_ENABLED
	vec4 normalmap = texture2D(normals, texcoord);
	#endif
	#ifdef SPECULARMAP_ENABLED
	vec4 specularmap = texture2D(specular, texcoord);
	#endif

	#ifdef NORMALS_ENABLED
	color = applyNormals(normalmap, color, gbufferModelViewInverse, sunPosition, NORMALS_STRENGTH, tbn, worldTime);
	#endif

	#ifdef NORMALS_LAB_AO_ENABLED
	float AO = normalmap.b * NORMALS_LAB_AO_STRENGTH;
	color *= AO;
	#endif

	#ifdef SPECULAR_EMISSIVE_ENABLED
		color = applyEmission(specularmap, color, SPECULAR_EMISSIVE_STRENGTH);
	#endif

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}