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