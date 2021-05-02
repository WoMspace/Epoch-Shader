#version 120

#include "lib/settings.glsl"

uniform sampler2D lightmap;
uniform sampler2D texture;

#if defined(NORMALS_ENABLED) || defined(NORMALS_LAB_AO_ENABLED)
uniform sampler2D normals;
#endif


uniform mat4 gbufferModelViewInverse;
uniform vec3 sunPosition;
const float sunPathRotation = -25.0;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying mat3 tbn;


void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color *= texture2D(lightmap, lmcoord);

	#ifdef NORMALS_ENABLED
	vec3 normalMap = texture2D(normals, texcoord).xyz * 2.0 - 1.0;
    normalMap.z = sqrt(clamp(1.0 - dot(normalMap.xy, normalMap.xy), 0.0, 1.0));
    normalMap = tbn * normalMap;
    normalMap = mat3(gbufferModelViewInverse) * normalMap;
    //normalMap = normalize(normalMap);

	vec3 sunDirection = mat3(gbufferModelViewInverse) * sunPosition;
	float normalDarkness = clamp(dot(normalMap, sunDirection)/25.0 * NORMALS_STRENGTH, 0.5, 1.25);
	color *= normalDarkness;
	#endif

	#ifdef NORMALS_LAB_AO_ENABLED
	float AO = texture2D(normals, texcoord).b * NORMALS_LAB_AO_STRENGTH;
	color *= AO;
	#endif

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}