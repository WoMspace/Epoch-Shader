vec3 extractNormalMap(vec4 normal, mat3 tbn, mat4 gbufferModelViewInverse)
{
	vec3 normalMap = normal.xyz * 2.0 - 1.0;
	normalMap.z = sqrt(clamp(1.0 - dot(normalMap.xy, normalMap.xy), 0.0, 1.0));
	normalMap = tbn * normalMap;
	normalMap = mat3(gbufferModelViewInverse) * normalMap;
	return normalMap;
}

vec4 applyNormals(vec4 normal, vec4 color, mat4 gbufferModelViewInverse, vec3 sunPosition, float normalStrength, mat3 tbn, int worldTime, vec3 skyColor)
{
	vec3 normalMap = extractNormalMap(normal, tbn, gbufferModelViewInverse);
	vec3 sunDirection = mat3(gbufferModelViewInverse) * sunPosition;
	float normalDarkness = clamp(dot(normalMap, sunDirection)/25.0 * normalStrength, 0.5, 1.25);
	vec3 celestialColor = vec3(HDR_SUNLIGHT_RED, HDR_SUNLIGHT_GREEN, HDR_SUNLIGHT_BLUE);
	vec3 shadeColor = skyColor * normalDarkness;
	if(worldTime > 13000)
	{
		celestialColor = vec3(HDR_MOONLIGHT_RED, HDR_MOONLIGHT_GREEN, HDR_MOONLIGHT_BLUE);
		normalDarkness = 1.0;
	}
	color.rgb *= mix(shadeColor, celestialColor, normalDarkness);
	return color;
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