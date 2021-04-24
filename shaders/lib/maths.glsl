vec2 clip(vec2 p)
{
    p = (p*2.0) - 1.0;//clip space
    return p;
}
vec2 unclip(vec2 p)
{
    p = (p+1.0)*0.5;//unclip space
	return p;
}

vec2 distort(vec2 temptexcoord, float strength) //THANKYOU JustTech#2594 from sLABS!
{//converts UVs to polar coordinates and back again. FOV dependant :D
    vec2 clipcoord = temptexcoord - vec2(0.5);
    float polarAngle = atan(clipcoord.x, clipcoord.y);
    float polarDistance = length(clipcoord);
    float distortAmount = strength * (-1.0);
    polarDistance = polarDistance * (1.0 + distortAmount * polarDistance * polarDistance);
    vec2 distortedUVs = vec2(0.5) + vec2(sin(polarAngle), cos(polarAngle)) * polarDistance;
    return distortedUVs;
}