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

vec3 applyLightmap(vec3 color, vec2 lmcoord, vec3 skyColor)
{
	vec3 blockLight = vec3(HDR_BLOCKLIGHT_RED, HDR_BLOCKLIGHT_GREEN, HDR_BLOCKLIGHT_BLUE) * lmcoord.x * HDR_BLOCKLIGHT_STRENGTH;
	vec3 skyLight = skyColor * lmcoord.y * HDR_AMBIENTLIGHT_STRENGTH;
<<<<<<< HEAD
	if(worldTime > 13000)
	{
		skyLight = vec3(HDR_MOONLIGHT_RED, HDR_MOONLIGHT_GREEN, HDR_MOONLIGHT_BLUE) * lmcoord.y * HDR_AMBIENTLIGHT_STRENGTH * 0.001;
	}
=======
>>>>>>> parent of 646451e (sis idek)
	
	return color * max(skyLight, blockLight);
	//return color * mix(skyLight, blockLight, min(lmcoord.x, lmcoord.y) + HDR_MINLIGHT);
}