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
{
    if(color.r > 0.66)
    {
        color.r *= grade[0].r;
    }
    else if(color.r < 0.33)
    {
        color.r *= grade[2].r;
    }
    else
    {
        color.r *= grade[1].r;
    }

    if(color.g > 0.66)
    {
        color.g *= grade[0].g;
    }
    else if(color.g < 0.33)
    {
        color.g *= grade[2].g;
    }
    else
    {
        color.g *= grade[1].g;
    }

    if(color.b > 0.66)
    {
        color.b *= grade[0].b;
    }
    else if(color.b < 0.33)
    {
        color.b *= grade[2].b;
    }
    else
    {
        color.b *= grade[1].b;
    }

    return color;
}

vec3 colorFilm(vec3 color, float strength)
{
    vec3 filmColorHighlight = vec3(1.5, 1.0, 1.0);
    vec3 filmColorShadow = vec3(1.0, 1.2, 1.1);

    color = contrast(color, FILM_BRIGHTNESS, FILM_CONTRAST);
    
    mat3 filmGrade;
    filmGrade[0] = vec3(1.5, 1.0, 1.0);
    filmGrade[1] = vec3(1.0);
    filmGrade[2] = vec3(1.0, 1.2, 1.0);

    color = colorGrade(color, filmGrade * COLORFILM_STRENGTH);

    return color;
}