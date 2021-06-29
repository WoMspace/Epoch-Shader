vec3 extractNormalMap(vec4 normal, mat3 tbn, mat4 gbufferModelViewInverse)
{
	vec3 normalMap = normal.xyz * 2.0 - 1.0;
	normalMap.z = sqrt(clamp(1.0 - dot(normalMap.xy, normalMap.xy), 0.0, 1.0));
	normalMap = tbn * normalMap;
	normalMap = mat3(gbufferModelViewInverse) * normalMap;
	return normalMap;
}

float getNormals(vec4 normal, mat4 gbufferModelViewInverse, vec3 shadowLightPosition, mat3 tbn)
{
	vec3 normalMap = extractNormalMap(normal, tbn, gbufferModelViewInverse);
	vec3 celestialDirection = mat3(gbufferModelViewInverse) * shadowLightPosition;
	return clamp(dot(normalMap, celestialDirection) * 0.01 * NORMALMAP_STRENGTH, 0.0, 1.0);
}

vec4 applyEmission(vec4 specular, vec4 color, float strength)
{
	float emission = specular.a;
	if(emission > 0.997)
	{
		emission = 0.0;
	}
	return color * (emission * strength + 1.0);
}

vec3 screenSpaceReflection(vec3 normal, float specularRoughness)
{
	return normal;
}