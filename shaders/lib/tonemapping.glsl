//color space conversions from https://github.com/Jessie-LC/open-source-utility-code. Thanks Jessie!

vec3 srgbToLinear(in vec3 srgb) {
    return pow(srgb, vec3(2.2));
}

vec3 linearToSRGB(in vec3 linear) {
    return pow(linear, vec3(1.0/2.2));
}

vec3 hejlBurgess(vec3 color, float exposure)
{
	color *= exposure;
	vec3 x = max(vec3(0.0), color - 0.004);
	color = (x * (6.2 * x + 0.5)) / (x * (6.2 * x + 1.7) + 0.06);
	return color;
}
vec3 hejlBurgess(vec3 color)
{
	vec3 x = max(vec3(0.0), color - 0.004);
	color = (x * (6.2 * x + 0.5)) / (x * (6.2 * x + 1.7) + 0.06);
	return color;
}

vec3 applyLightmap(vec3 color, vec2 lmcoord, vec3 skyColor, int worldTime, float shadowAmount, float normalAmount, mat4 gbufferModelView, vec3 sunPosition)
{
	vec3 blockLight = vec3(HDR_BLOCKLIGHT_RED, HDR_BLOCKLIGHT_GREEN, HDR_BLOCKLIGHT_BLUE) * lmcoord.x * HDR_BLOCKLIGHT_STRENGTH;
	vec3 ambientColor = skyColor;
	vec3 sunlightColor = vec3(HDR_SUNLIGHT_RED, HDR_SUNLIGHT_GREEN, HDR_SUNLIGHT_BLUE) * lmcoord.y * HDR_SUNLIGHT_STRENGTH;
	vec3 moonLightColor = vec3(HDR_MOONLIGHT_RED, HDR_MOONLIGHT_GREEN, HDR_MOONLIGHT_BLUE) * lmcoord.y * HDR_MOONLIGHT_STRENGTH;

	float celestialSwapBrightness = min(max(smoothstep(13000.0, 11000.0, worldTime), smoothstep(13000.0, 15000.0, worldTime)), max(smoothstep(23000.0, 21000.0, worldTime), smoothstep(23000.0, 24000.0, worldTime)));
	float celestialMix = clamp(dot(normalize(sunPosition), gbufferModelView[1].xyz), 0.0, 1.0); //some function to carefully mix between sun and moon
	vec3 celestialLight = mix(moonLightColor, sunlightColor, celestialMix) * celestialSwapBrightness;
	vec3 lightColor = mix(ambientColor, celestialLight, shadowAmount * normalAmount * celestialSwapBrightness);
	return color * lightColor;
}