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

bool floatEquals(float op1, float op2, float difference)
{
	return abs(op1 - op2) < difference;
}

float generateNoise(vec2 spatialSeed, float temporalSeed)
{
	return 1.0;
}

const float e = 2.7182818;
const vec3 vec3e = vec3(e);
#define e(x) pow(vec3e, x)