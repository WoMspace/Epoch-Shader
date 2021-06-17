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

const vec3 lumacoeff_rec709 = vec3(0.2125, 0.7154, 0.0721);
vec3 JessieTonemap(vec3 x) {
	x *= 2.0;
	float a = 0.6;
	float b = 0.15;
	float c = dot(x, lumacoeff_rec709);
	c = c*b;
	vec3 div = 1.0 + c + exp(1.0/a) * x;
	div *= 1.0/5.0;
	return x * (1.0/(1.0 + div));
}

vec3 applyLightmap(vec3 color, vec2 lmcoord, vec3 skyColor, int worldTime, float shadowAmount, float normalAmount, mat4 gbufferModelView, vec3 sunPosition)
{
	vec3 blockLight = vec3(HDR_BLOCKLIGHT_RED, HDR_BLOCKLIGHT_GREEN, HDR_BLOCKLIGHT_BLUE) * (lmcoord.x - 0.03125)  * HDR_BLOCKLIGHT_STRENGTH;
	vec3 skyLight = lmcoord.y * skyColor;

	#ifdef SHADOWS_ENABLED
	vec3 ambientColor = max(skyColor, vec3(0.0015, 0.0015, 0.0025) * HDR_MINLIGHT);
	#else
	vec3 ambientColor = max(skyColor * 1.5, vec3(0.015, 0.015, 0.025) * HDR_MINLIGHT);
	#endif

	vec3 sunlightColor = vec3(HDR_SUNLIGHT_RED, HDR_SUNLIGHT_GREEN, HDR_SUNLIGHT_BLUE) * lmcoord.y * HDR_SUNLIGHT_STRENGTH;
	vec3 moonLightColor = vec3(HDR_MOONLIGHT_RED, HDR_MOONLIGHT_GREEN, HDR_MOONLIGHT_BLUE) * lmcoord.y * HDR_MOONLIGHT_STRENGTH;

	float celestialSwapBrightness = min(max(smoothstep(13000.0, 11000.0, float(worldTime)), smoothstep(13000.0, 15000.0, float(worldTime))), max(smoothstep(23000.0, 21000.0, float(worldTime)), smoothstep(23000.0, 24000.0, float(worldTime))));
	float celestialMix = clamp(dot(normalize(sunPosition), gbufferModelView[1].xyz), 0.0, 1.0); //some function to carefully mix between sun and moon
	vec3 celestialLight = mix(moonLightColor, sunlightColor, celestialMix) * celestialSwapBrightness;
	vec3 lightColor = mix(ambientColor, celestialLight, shadowAmount * normalAmount * celestialSwapBrightness);

	return color * max(lightColor, blockLight);
}
//return color * mix(skyLight, blockLight, lightInfluence);

#define TONEMAP_TOE_STRENGTH	0.0   // [-1.0 -0.99 -0.98 -0.97 -0.96 -0.95 -0.94 -0.93 -0.92 -0.91 -0.9 -0.89 -0.88 -0.87 -0.86 -0.85 -0.84 -0.83 -0.82 -0.81 -0.8 -0.79 -0.78 -0.77 -0.76 -0.75 -0.74 -0.73 -0.72 -0.71 -0.7 -0.69 -0.68 -0.67 -0.66 -0.64 -0.63 -0.62 -0.61 -0.6 -0.59 -0.58 -0.57 -0.56 -0.55 -0.54 -0.53 -0.52 -0.51 -0.5 -0.49 -0.48 -0.47 -0.46 -0.45 -0.44 -0.43 -0.42 -0.41 -0.4 -0.39 -0.38 -0.37 -0.36 -0.35 -0.34 -0.33 -0.32 -0.31 -0.3 -0.29 -0.28 -0.27 -0.26 -0.25 -0.24 -0.23 -0.22 -0.21 -0.2 -0.19 -0.18 -0.17 -0.16 -0.15 -0.14 -0.13 -0.12 -0.11 -0.1 -0.09 -0.08 -0.07 -0.06 -0.05 -0.04 -0.03 -0.02 -0.01 0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0]
#define TONEMAP_TOE_LENGTH	  0.0   // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0]
#define TONEMAP_LINEAR_SLOPE	1.0   // Should usually be left at 1
#define TONEMAP_LINEAR_LENGTH   0.0   // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0]
#define TONEMAP_SHOULDER_CURVE  0.5 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0]
#define TONEMAP_SHOULDER_LENGTH 1.0   // Not currently in an actually useful state

float ZombyeTonemapCurve(float x) {
	const float toeStrength	= TONEMAP_TOE_STRENGTH;
	const float toeLength	  = TONEMAP_TOE_LENGTH * TONEMAP_TOE_LENGTH / 2;
	const float linearSlope	= TONEMAP_LINEAR_SLOPE;
	const float linearLength   = TONEMAP_LINEAR_LENGTH;
	const float shoulderCurve  = TONEMAP_SHOULDER_CURVE;
	const float shoulderLength = TONEMAP_SHOULDER_LENGTH;

	const float toeX	 = toeLength;
	const float toeY	 = linearSlope * toeLength * (1.0 - toeStrength);
	const float toePower = 1.0 / (1.0 - toeStrength);

	const float tm = toeY * pow(1.0 / toeX, toePower);

	const float lm = linearSlope;
	const float la = toeStrength == 1.0 ? -linearSlope * toeX : toeY - toeY * toePower;

	const float shoulderX = linearLength * (1.0 - toeY) / linearSlope + toeX;
	const float shoulderY = linearLength * (1.0 - toeY) + toeY;

	const float sim = linearSlope * shoulderLength / (1.0 - shoulderY);
	const float sia = -sim * shoulderX;
	const float som = (1.0 - shoulderY) / shoulderLength;
	const float soa = shoulderY;

	float y;
	if (x < toeX) {
		y = tm * pow(x, toePower);
	} else if (x < shoulderX) {
		y = lm * x + la;
	} else {
		y  = sim * x + sia;
		y /= pow(pow(y, 1.0 / shoulderCurve) + 1.0, shoulderCurve);
		y  = som * y + soa;
	}

	return y;
}
vec3 ZombyeTonemap(vec3 color) {
	for (int component = 0; component < 3; ++component) {
		color[component] = ZombyeTonemapCurve(color[component]);
	}
	return color;
}
vec3 TechTonemap(vec3 color)
{
	vec3 a = color * min(vec3(1.0), 1.0 - exp(-1.0 / 0.035 * color));
	a = mix(a, color, color * color);
	return a / (a + 0.7);
}

vec3 tonemapSelector(vec3 color)
{
	#if TONEMAP_OPERATOR == TONEMAP_BURGESS
	return hejlBurgess(color);
	#elif TONEMAP_OPERATOR == TONEMAP_JESSIE
	return JessieTonemap(color) * 1.5;
	#elif TONEMAP_OPERATOR == TONEMAP_ZOMBYE
	return linearToSRGB(ZombyeTonemap(color));
	#elif TONEMAP_OPERATOR == TONEMAP_TECH
	return linearToSRGB(TechTonemap(color));
	#endif
}