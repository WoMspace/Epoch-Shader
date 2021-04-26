vec2 clip(vec2 p)
{
	p = p * 2.0 - 1.0;//clip space
	return p;
}
vec2 unclip(vec2 p)
{
	p = p * 0.5 + 0.5;//unclip space
	return p;
}

vec2 distort(vec2 coord, float strength) { //Builderb0y has made an entirely (atan-free) cartesian distortion function. Dang.
    coord -= vec2(0.5);
    coord *= 1.0 - strength * dot(coord, coord);
    return coord + vec2(0.5);
}