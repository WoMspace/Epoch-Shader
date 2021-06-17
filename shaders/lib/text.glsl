/*
Text Rendering Library
Requires #version 130 or greater
*/

#include "ascii.glsl"

//change this to change color of text.
const vec3 textColor = vec3(1.0);

//change this to change color of text background.
const vec3 bgColor = vec3(0.0);

// the size in on-screen pixels of each font pixel.
const int characterPixelWidth = 10;


vec3 renderChar(int asciiCode, int characterIndex, vec3 passthroughColor)
{ // asciiCode is the... ascii code...
  // characterIndex is how far along the character is.

	vec2 pixelCoord = floor(gl_FragCoord).xy;
	pixelCoord = mod(pixelCoord, vec2(8.0 * float(characterPixelWidth)));

	if(pixelCoord.y > characterPixelWidth)
	{
		return passthroughColor;
	}

	int charInt = ascii[asciiCode].int1;
	int bitIndex = int(floor(mod(pixelCoord.y * 2.0 + pixelCoord.x, 32.0)));
	if(bitIndex > 32)
	{
		charInt = ascii[asciiCode].int2;
	}

	if(((charInt >> bitIndex) & 1) > 0)
	{//DRAW A BIT!
		return textColor;
	}
	else
	{
		return bgColor;
	}

	// return mix(textColor, bgColor, step(float((charInt >> bitIndex) & 1)));
}

void renderText()
{
    
}

// struct byte
// {
// 	bool[8];
// }
// byte intToByte(int input)
// {
// 	byte output = byte(
// 		input & 1,
// 		input & 2,
// 		input & 4,
// 		input & 8,
// 		input & 16,
// 		input & 32,
// 		input & 64
// 	);
// 	return output;
// }

struct string
{ // strings are an array of ascii values
	int character[];
};