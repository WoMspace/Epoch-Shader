#version 120

#include "lib/settings.glsl"
#include "lib/labPBR.glsl"
#include "lib/tonemapping.glsl"
#include "lib/bokeh.glsl"

#define FSH

uniform sampler2D lightmap;
uniform sampler2D texture;

#ifdef NORMALMAP_ENABLED
uniform sampler2D normals;
#endif
#ifdef SPECULARMAP_ENABLED
uniform sampler2D specular;
#endif

uniform sampler2D shadowtex0;
varying vec4 shadowPos;

#include "lib/shadows.glsl"

uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferModelView;
uniform vec3 sunPosition;
uniform vec3 shadowLightPosition;
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
	#ifdef NORMALMAP_ENABLED
	vec4 normalmap = texture2D(normals, texcoord);
	#endif
	#ifdef SPECULARMAP_ENABLED
	vec4 specularmap = texture2D(specular, texcoord);
	#endif

	vec4 color = texture2D(texture, texcoord) * glcolor;
	color.rgb = srgbToLinear(color.rgb);
	float normalDarkness = getNormals(normalmap, gbufferModelViewInverse, shadowLightPosition, tbn);
	color.rgb = applyLightmap(color.rgb, lmcoord, skyColor, worldTime, calculateShadows(shadowtex0, shadowPos), normalDarkness, gbufferModelView, sunPosition);

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
	#if FILM_MODE == FILM_THERMAL
	gl_FragData[1] = vec4(color2, temperature);
	#endif
}