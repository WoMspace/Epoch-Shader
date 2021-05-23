#version 120

#include "lib/settings.glsl"
#include "lib/labPBR.glsl"
#include "lib/tonemapping.glsl"

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
uniform vec3 skyColor;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying mat3 tbn;
#if FILM_MODE == FILM_THERMAL
uniform sampler2D colortex2;
varying float blockTemp;
#endif

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color.rgb = srgbToLinear(color.rgb);
	color.rgb = applyLightmap(color.rgb, lmcoord, skyColor, worldTime);

	#ifdef NORMALMAP_ENABLED
	vec4 normalmap = texture2D(normals, texcoord);
	#endif
	#ifdef SPECULARMAP_ENABLED
	vec4 specularmap = texture2D(specular, texcoord);
	#endif

	#ifdef NORMALS_ENABLED
	color = applyNormals(normalmap, color, gbufferModelViewInverse, sunPosition, NORMALS_STRENGTH, tbn, worldTime, skyColor);
	#endif

	#ifdef NORMALS_LAB_AO_ENABLED
	float AO = normalmap.b * NORMALS_LAB_AO_STRENGTH;
	color *= AO;
	#endif

	#ifdef SPECULAR_EMISSIVE_ENABLED
		color = applyEmission(specularmap, color, SPECULAR_EMISSIVE_STRENGTH);
	#endif

	#if FILM_MODE == 3 //thermal camera
	vec3 color2 = texture2D(colortex2, texcoord).rgb;
	float temperature = float(blockTemp - 1000) / 4.0;
	#endif

/* DRAWBUFFERS:02 */
	gl_FragData[0] = color; //gcolor
}