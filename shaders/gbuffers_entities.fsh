#version 120

#define FSH

#include "lib/settings.glsl"
#include "lib/labPBR.glsl"
#include "lib/tonemapping.glsl"

uniform sampler2D lightmap;
uniform sampler2D texture;
uniform vec4 entityColor;
uniform mat4 gbufferModelViewInverse;
uniform vec3 sunPosition;
uniform int worldTime;
uniform vec3 skyColor;

uniform sampler2D normals;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying mat3 tbn;

#define FSH
uniform sampler2D shadowtex0;
varying vec4 shadowPos;
#include "lib/shadows.glsl"
uniform mat4 gbufferModelView;
uniform vec3 shadowLightPosition;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	vec4 normalmap = texture2D(normals, texcoord);
	color.rgb = srgbToLinear(color.rgb);
	color.rgb = mix(color.rgb, entityColor.rgb, entityColor.a);
	float normalDarkness = getNormals(normalmap, gbufferModelViewInverse, shadowLightPosition, tbn);
	color.rgb = applyLightmap(color.rgb, lmcoord, skyColor, worldTime, calculateShadows(shadowtex0, shadowPos), normalDarkness, gbufferModelView, sunPosition);

	#ifdef NORMALS_LAB_AO_ENABLED
	float AO = normalmap.b * NORMALS_LAB_AO_STRENGTH;
	color.rgb *= vec3(AO);
	#endif

	//color = normalmap;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color.rgb, ceil(color.a)); //gcolor
}