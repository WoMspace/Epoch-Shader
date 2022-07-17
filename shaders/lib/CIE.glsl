vec3 xriteChart(vec2 uv)
{
	if(uv.x < 0.15) // first column
	{
		if(uv.y >= 0.75)	{ return vec3(115.0, 82.0, 68.0) / 255.0; } // Dark Skin
		else if(uv.y <= 0.75 && uv.y > 0.5) { return vec3(214.0, 126.0, 44.0) / 255.0; } // Orange
		else if(uv.y <= 0.5 && uv.y > 0.25) { return vec3(56.0, 61.0, 150.0) / 255.0; } // Blue
		else { return vec3(243.0, 243.0, 242.0) / 255.0; } // White
	}
	else if(uv.x >= 0.15 && uv.x < 0.3) // second column
	{
		if(uv.y >= 0.75)	{ return vec3(194.0, 150.0, 130.0) / 255.0; } // Light Skin
		else if(uv.y <= 0.75 && uv.y > 0.5) { return vec3(80.0, 91.0, 166.0) / 255.0; } // Purple Red
		else if(uv.y <= 0.5 && uv.y > 0.25) { return vec3(70.0, 148.0, 73.0) / 255.0; } // Green
		else { return vec3(200.0, 200.0, 200.0) / 255.0; } // Neutral 8
	}
	else if(uv.x >= 0.3 && uv.x < 0.45) // third column
	{
		if(uv.y >= 0.75)	{ return vec3(98.0, 122.0, 157.0) / 255.0; } // Blue Sky
		else if(uv.y <= 0.75 && uv.y > 0.5) { return vec3(193.0, 90.0, 99.0) / 255.0; } // Moderate Red
		else if(uv.y <= 0.5 && uv.y > 0.25) { return vec3(175.0, 54.0, 60.0) / 255.0; } // Red
		else { return vec3(160.0, 160.0, 160.0) / 255.0; } // Neutral 65
	}
	else if(uv.x >= 0.45 && uv.x < 0.60) // fourth column
	{
		if(uv.y >= 0.75)	{ return vec3(87.0, 108.0, 67.0) / 255.0; } // Foliage
		else if(uv.y <= 0.75 && uv.y > 0.5) { return vec3(94.0, 60.0, 108.0) / 255.0; } // Purple
		else if(uv.y <= 0.5 && uv.y > 0.25) { return vec3(231.0, 199.0, 31.0) / 255.0; } // Yellow
		else { return vec3(122.0, 122.0, 121.0) / 255.0; } // Neutral 5
	}
	else if(uv.x >= 0.6 && uv.x < 0.75) // fifth column
	{
		if(uv.y >= 0.75)	{ return vec3(133.0, 128.0, 177.0) / 255.0; } // Blue Flower
		else if(uv.y <= 0.75 && uv.y > 0.5) { return vec3(157.0, 188.0, 64.0) / 255.0; } // Yellow Green
		else if(uv.y <= 0.5 && uv.y > 0.25) { return vec3(187.0, 86.0, 149.0) / 255.0; } // Magenta
		else { return vec3(85.0) / 255.0; } // Neutral 35
	}
	else if(uv.x >= 0.75) // sixth column
	{
		if(uv.y >= 0.75)	{ return vec3(103.0, 189.0, 170.0) / 255.0; } // Bluish Green
		else if(uv.y <= 0.75 && uv.y > 0.5) { return vec3(224.0, 163.0, 46.0) / 255.0; } // Orange Yellow
		else if(uv.y <= 0.5 && uv.y > 0.25) { return vec3(8.0, 133.0, 161.0) / 255.0; } // Cyan
		else { return vec3(52.0) / 255.0; } // Black
	}
}

// https://docs.opencv.org/3.1.0/de/d25/imgproc_color_conversions.html#color_convert_rgb_lab

vec3 sRGB_to_LINEAR(vec3 sRGB)
{ // Thanks Jodie!
    return 0.315206 * sRGB * ((2.10545 + sRGB) * (0.0231872 + sRGB));
}
vec3 LINEAR_to_sRGB(vec3 RGB)
{
    return 1.14374 * (-0.126893 * RGB + sqrt(RGB));
}

mat3 CIEXYZ_Matrix = mat3(
	0.412453, 0.212671, 0.019334,
	0.357580, 0.715160, 0.119193,
	0.180423, 0.072169, 0.950227
);
vec3 RGB_to_CIEXYZ(vec3 RGB)
{
	vec3 XYZ = CIEXYZ_Matrix * RGB;
	XYZ.x /= 0.950456;
	XYZ.z /= 1.088754;
	return XYZ;
}
// vec3 CIEXYZ_to_RGB(vec3 XYZ)
// {
// 	XYZ.x *= 0.950456;
// 	XYZ.z /= 1.088754;
// }

float f(float t)
{
	if(t > 0.008856) { return pow(t, 1.0/3.0); }
	else { return 7.787 * t + 16.0/116.0; }
}
vec3 CIEXYZ_to_CIELAB(vec3 XYZ)
{
	vec3 LAB;

	// L
	if(XYZ.y > 0.008856) { LAB.x = 116.0 * pow(XYZ.y, 1.0/3.0) - 16.0; }
	else { LAB.x = 903.3 * XYZ.y; }

	// a
	LAB.y = 500.0 * (f(XYZ.x) - f(XYZ.y)) + 128.0; // 128 is DELTA
	// b
	LAB.z = 200.0 * (f(XYZ.y) - f(XYZ.z)) + 128.0; // 128 is DELTA

	// Now convert back to 8-bit image
	// LAB.x *= 255.0 / 100.0;
	// LAB.y += 128.0;
	// LAB.z += 128.0;

	// This is in 32-bit float values.
	return LAB;
}

vec3 sRGB_to_CIELAB(vec3 sRGB)
{
	vec3 RGB = sRGB_to_LINEAR(sRGB);
	vec3 XYZ = RGB_to_CIEXYZ(RGB);
	vec3 LAB = CIEXYZ_to_CIELAB(XYZ);
	return LAB;
}