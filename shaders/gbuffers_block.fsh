#version 120

#define FSH

#include "lib/settings.glsl"
#include "lib/labPBR.glsl"
#include "lib/tonemapping.glsl"

uniform sampler2D lightmap;
uniform sampler2D texture;
#ifdef SHADOWS_ENABLED
uniform sampler2D shadowtex0;
#endif

uniform sampler2D normals;
#ifdef SPECULARMAP_ENABLED
uniform sampler2D specular;
#endif

uniform mat4 shadowProjection;
uniform mat4 shadowModelView;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 shadowLightPosition;
uniform vec3 sunPosition;
const float sunPathRotation = -25.0;
uniform int worldTime;
uniform vec3 skyColor;
varying vec4 shadowPos;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying mat3 tbn;
#if FILM_MODE == FILM_THERMAL
uniform sampler2D colortex2;
varying float blockTemp;
#endif

#include "lib/shadows.glsl"

void main() {
	vec4 normalmap = texture2D(normals, texcoord);
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color.rgb = srgbToLinear(color.rgb);
	float normalDarkness = getNormals(normalmap, gbufferModelViewInverse, shadowLightPosition, tbn);
	#ifdef SHADOWS_ENABLED
	color.rgb = applyLightmap(color.rgb, lmcoord, skyColor, worldTime, calculateShadows(shadowtex0, shadowPos), normalDarkness, gbufferModelView, sunPosition);
	#else
	color.rgb = applyLightmap(color.rgb, lmcoord, skyColor, worldTime, 1.0, normalDarkness, gbufferModelView, sunPosition);
	#endif

	#ifdef SPECULARMAP_ENABLED
	vec4 specularmap = texture2D(specular, texcoord);
	#endif

	#ifdef NORMALS_LAB_AO_ENABLED
	if(normalmap.r > 0.01)
	{
		float AO = normalmap.b * NORMALS_LAB_AO_STRENGTH;
		color.rgb *= vec3(AO);
	}
	#endif

	#ifdef SPECULAR_EMISSIVE_ENABLED
		color = applyEmission(specularmap, color, SPECULAR_EMISSIVE_STRENGTH);
	#endif

	#if FILM_MODE == 3 //thermal camera
	vec3 color2 = texture2D(colortex2, texcoord).rgb;
	float temperature = float(blockTemp - 1000) / 4.0;
	#endif

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}