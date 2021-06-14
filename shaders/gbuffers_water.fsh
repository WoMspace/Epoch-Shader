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
uniform vec3 skyColor;
uniform int worldTime;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 shadowLightPosition;
uniform vec3 sunPosition;

varying mat3 tbn;
varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying vec4 shadowPos;

#include "lib/shadows.glsl"

void main() {
	vec4 normalmap = texture2D(normals, texcoord);
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color.rgb = srgbToLinear(color.rgb);
	float normalDarkness = getNormals(normalmap, gbufferModelViewInverse, shadowLightPosition, tbn);
	#if !defined(MOLLY_LIT_TRANSLUCENTS_ENABLED) && defined(SHADOWS_ENABLED)
	color.rgb = applyLightmap(color.rgb, lmcoord, skyColor, worldTime, calculateShadows(shadowtex0, shadowPos), normalDarkness, gbufferModelView, sunPosition).rgb;
	#elif defined(MOLLY_LIT_TRANSLUCENTS_ENABLED)
	#else
	color.rgb = applyLightmap(color.rgb, lmcoord, skyColor, worldTime, 1.0, normalDarkness, gbufferModelView, sunPosition).rgb;
	#endif
	//color.a *= 1.25;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}