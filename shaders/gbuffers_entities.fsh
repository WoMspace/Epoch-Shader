#version 120

#include "lib/settings.glsl"
#include "lib/labPBR.glsl"

uniform sampler2D lightmap;
uniform sampler2D texture;
uniform vec4 entityColor;
uniform mat4 gbufferModelViewInverse;
uniform vec3 sunPosition;
uniform int worldTime;

#ifdef NORMALMAP_ENABLED
uniform sampler2D normals;
#endif

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying mat3 tbn;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color.rgb = mix(color.rgb, entityColor.rgb, entityColor.a);
	color *= texture2D(lightmap, lmcoord);
	#if defined(NORMALS_ENABLED) || defined(NORMALS_LAB_AO_ENABLED)
	vec4 normalmap = texture2D(normals, texcoord);
	#endif

	#ifdef NORMALS_ENABLED
	color = applyNormals(normalmap, color, gbufferModelViewInverse, sunPosition, NORMALS_STRENGTH, tbn, worldTime);
	#endif

	#ifdef NORMALS_LAB_AO_ENABLED
	float AO = normalmap.b * NORMALS_LAB_AO_STRENGTH;
	color *= AO;
	#endif

	//color = normalmap;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}