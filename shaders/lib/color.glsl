#extension GL_EXT_gpu_shader4 : enable

float extractLuma(vec3 color)
{
	float luma = (color.r + color.g + color.b)/3.0;
	return luma;
}
vec3 extractLuma(vec3 color, vec3 influence)
{
	float luma = color.r * influence.r;
	luma += color.g * influence.g;
	luma += color.b * influence.b;
	color = vec3(luma/3.0);
	return color;
}

vec3 threshold(vec3 color, float threshold)
{
	float luma = extractLuma(color);
	return mix(vec3(0.0), color, step(threshold, luma));
}

vec3 contrast(vec3 color, float midpoint, float strength)
{
	color -= -midpoint + 0.5;
	color *= strength;
	color += -midpoint + 0.5;
	return color;
}

vec3 colorGrade(vec3 color, mat3 grade)
{//the mat3 is basically a really simple LUT for RGB in highlights, mids, and shadows.
	float luma = extractLuma(color);
	vec3 highlights = mix(color, color * grade[0], luma * 3.0 - 2.0); //highlights with... rolloff?
	vec3 midtones = mix(color, color * grade[1], sin(luma * 3.0)); //midtones with... rolloff?
	vec3 shadows = mix(color, color * grade[2], sin(luma * 3.0 + 45.0)); //shadows with... rolloff?
	return (highlights + midtones + shadows) / 3.0;
}
vec3 discreteColorGrade(vec3 color, mat3 grade)
{//applies to EITHER shadow, mid, or highlight. Causes color casting.
	float luma = extractLuma(color);
	if(luma > 0.6666)
	{//it's a highlight
		color *= grade[0] * (luma * 3.0 - 2.0);
	}
	else if(luma < 0.3333)
	{//it's a shadow
		color *= grade[2] * (luma * 0.3333 + 2.0);
	}
	else
	{//it's a midtone
		color *= grade[1] * 0.5;
	}
	return color;
}

vec3 colorFilm(vec3 color, float strength)
{
	vec3 filmColorHighlight = vec3(1.5, 1.0, 1.0);
	vec3 filmColorShadow = vec3(1.0, 1.2, 1.1);

	color = contrast(color, FILM_BRIGHTNESS, FILM_CONTRAST);
	
	mat3 filmGrade = mat3(
		1.4, 1.2, 0.9,
		1.2, 1.0, 0.8,
		0.9, 1.2, 0.9
	);
	color = colorGrade(color, filmGrade * COLORFILM_STRENGTH);
	return color;
}

const vec2 LUTBlueOffset[64] = vec2[](
	vec2(0.000, 0), vec2(0.125, 0), vec2(0.250, 0), vec2(0.375, 0), vec2(0.500, 0), vec2(0.625, 0), vec2(0.750, 0), vec2(0.875, 0), 
	vec2(0.000, 0.0125), vec2(0.125, 0.0125), vec2(0.250, 0.0125), vec2(0.375, 0.0125), vec2(0.500, 0.0125), vec2(0.625, 0.0125), vec2(0.750, 0.0125), vec2(0.875, 0.0125), 
	vec2(0.000, 0.025), vec2(0.125, 0.025), vec2(0.250, 0.025), vec2(0.375, 0.025), vec2(0.500, 0.025), vec2(0.625, 0.025), vec2(0.750, 0.025), vec2(0.875, 0.025), 
	vec2(0.000, 0.0375), vec2(0.125, 0.0375), vec2(0.250, 0.0375), vec2(0.375, 0.0375), vec2(0.500, 0.0375), vec2(0.625, 0.0375), vec2(0.750, 0.0375), vec2(0.875, 0.0375), 
	vec2(0.000, 0.05), vec2(0.125, 0.05), vec2(0.250, 0.05), vec2(0.375, 0.05), vec2(0.500, 0.05), vec2(0.625, 0.05), vec2(0.750, 0.05), vec2(0.875, 0.05), 
	vec2(0.000, 0.0625), vec2(0.125, 0.0625), vec2(0.250, 0.0625), vec2(0.375, 0.0625), vec2(0.500, 0.0625), vec2(0.625, 0.0625), vec2(0.750, 0.0625), vec2(0.875, 0.0625), 
	vec2(0.000, 0.075), vec2(0.125, 0.075), vec2(0.250, 0.075), vec2(0.375, 0.075), vec2(0.500, 0.075), vec2(0.625, 0.075), vec2(0.750, 0.075), vec2(0.875, 0.075), 
	vec2(0.000, 0.0875), vec2(0.125, 0.0875), vec2(0.250, 0.0875), vec2(0.375, 0.0875), vec2(0.500, 0.0875), vec2(0.625, 0.0875), vec2(0.750, 0.0875), vec2(0.875, 0.0875)
);

vec3 applyLUT(vec3 color, sampler2D LUT)
{
	color = clamp(color, 1e-6, 1.0);
	vec2 RGoffset = vec2(color.r / 8.0, color.g / 80.0);
	vec2 Boffset = LUTBlueOffset[int(color.b * 64.0)];
	vec2 LUToffset = Boffset + RGoffset;
	LUToffset.y += lut_selected;
	color = texture2D(LUT, LUToffset).rgb;
	return color;
}

const vec2 CustomLUTBlueOffsets[64] = vec2[] (
	vec2(0.000,0.000), vec2(0.125,0.000), vec2(0.250,0.000), vec2(0.375,0.000), vec2(0.500,0.000), vec2(0.625,0.000), vec2(0.750,0.000), vec2(0.875,0.000),
	vec2(0.000,0.125), vec2(0.125,0.125), vec2(0.250,0.125), vec2(0.375,0.125), vec2(0.500,0.125), vec2(0.625,0.125), vec2(0.750,0.125), vec2(0.875,0.125),
	vec2(0.000,0.250), vec2(0.125,0.250), vec2(0.250,0.250), vec2(0.375,0.250), vec2(0.500,0.250), vec2(0.625,0.250), vec2(0.750,0.250), vec2(0.875,0.250),
	vec2(0.000,0.375), vec2(0.125,0.375), vec2(0.250,0.375), vec2(0.375,0.375), vec2(0.500,0.375), vec2(0.625,0.375), vec2(0.750,0.375), vec2(0.875,0.375),
	vec2(0.000,0.500), vec2(0.125,0.500), vec2(0.250,0.500), vec2(0.375,0.500), vec2(0.500,0.500), vec2(0.625,0.500), vec2(0.750,0.500), vec2(0.875,0.500),
	vec2(0.000,0.625), vec2(0.125,0.625), vec2(0.250,0.625), vec2(0.375,0.625), vec2(0.500,0.625), vec2(0.625,0.625), vec2(0.750,0.625), vec2(0.875,0.625),
	vec2(0.000,0.750), vec2(0.125,0.750), vec2(0.250,0.750), vec2(0.375,0.750), vec2(0.500,0.750), vec2(0.625,0.750), vec2(0.750,0.750), vec2(0.875,0.750),
	vec2(0.000,0.875), vec2(0.125,0.875), vec2(0.250,0.875), vec2(0.375,0.875), vec2(0.500,0.875), vec2(0.625,0.875), vec2(0.750,0.875), vec2(0.875,0.875)
);

vec3 customLUT(vec3 color, sampler2D LUT)
{
	color = clamp(color, 1e-6, 1.0);
	vec2 RGOffset = vec2(color.r / 8.0, color.g / 8.0);
	vec2 Boffset = CustomLUTBlueOffsets[int(color.b * 64.0)];
	color = texture2D(LUT, RGOffset + Boffset).rgb;
	return color;
}

// vec3 hald_clut(vec3 oldColor, sampler2D hald)
// {
//     ivec3 rounded = ivec3(oldColor * 255.0);
//     int index = (rounded.b << 16) | (rounded.g << 8) | rounded.r;
//     ivec2 sampleCoord = ivec2(index & 4095, index >> 12);
//     vec3 newColor = texelFetch(hald, sampleCoord, 0).rgb;
// 	return mix(oldColor, newColor, LUT_STRENGTH);
// }


#define LUT_WIDTH 1728
#define LUT_DEPTH 144
vec3 hald_clut(vec3 oldColor, sampler2D hald)
{
	ivec3 rounded = ivec3(oldColor * float(LUT_DEPTH));
    int index = (rounded.b * LUT_DEPTH * LUT_DEPTH) + (rounded.g * LUT_DEPTH) + rounded.r;
    ivec2 sampleCoord = ivec2(index % LUT_WIDTH, index / LUT_WIDTH);
    vec3 newColor = texelFetch(hald, sampleCoord, 0).rgb;
	return mix(oldColor, newColor, LUT_STRENGTH);
}

float bayer2(vec2 uv) {
	uv = 0.5 * floor(uv);
	return fract(1.5 * fract(uv.y) + uv.x);
}
float bayer4(vec2 uv) {
	return 0.25 * bayer2(0.5 * uv) + bayer2(uv);
}
float bayer8(vec2 uv) {
	return 0.25 * bayer4(0.5 * uv) + bayer2(uv);
}
float bayer16(vec2 uv) {
	return 0.25 * bayer8(0.5 * uv) + bayer2(uv);
}
float bayer32(vec2 uv) {
	return 0.25 * bayer16(0.5 * uv) + bayer2(uv);
}
float bayer64(vec2 uv) {
	return 0.25 * bayer32(0.5 * uv) + bayer2(uv);
}
float bayer128(vec2 uv) {
	return 0.25 * bayer64(0.5 * uv) + bayer2(uv);
}