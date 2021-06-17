/*
Text Rendering Library
*/

//change this to change color of text.
const vec3 textColor = vec3(1.0);

const vec3 bgColor = vec3(0.0);

// the size in on-screen pixels of each font pixel.
const int characterPixelWidth = 2;


vec3 renderChar(int asciiCode, int characterIndex)
{ // asciiCode is the... ascii code...
  // characterIndex is how far along the character is.

	vec2 pixelCoord = floor(gl_FragCoord);
	pixelCoord = mod(pixelCoord, 8.0 * float(characterPixelWidth));
	character char = character(ascii[asciiCode]);

	int charInt = char[0]
	int bitIndex = mod(pixelCoord.y * 2.0 + pixelCoord.x, 32);
	if(bitIndex > 32)
	{
		charInt = char[1]
	}

	if((charInt >> bitIndex) & 1)
	{//DRAW A BIT!
		return textColor;
	}
	else
	{
		return bgColor;
	}
}

void renderText()
{
    
}

struct byte
{
	bool[8];
}
byte intToByte(int input)
{
	byte output = byte(
		input & 1,
		input & 2,
		input & 4,
		input & 8,
		input & 16,
		input & 32,
		input & 64
	);
	return output;
}

struct character
{ // since glsl doesn't have chars or strings, we have to define our own. Characters are just two ints.
	int int1;
	int int2;
}

struct string
{ // strings are an array of ascii values
	int character[];
}

// this is basically an ascii look-up table?
// ascii[index] will return the character with the ascii code of <index>
const character ascii[128] = character[] (
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(0, 0),
	character(406600728, 1572888),
	character(13878, 0),
	character(914306614, 3552895),
	character(503528972, 794416),
	character(406020864, 6514188),
	character(1847342620, 7222075),
	character(198150, 0),
	character(101059608, 1575942),
	character(404229126, 396312),
	character(-12818944, 26172),
	character(1057754112, 3084),
	character(0, 101452800),
	character(1056964608, 0),
	character(0, 789504),
	character(202911840, 66310),
	character(2071159614, 4089711),
	character(202116620, 4131852),
	character(472920862, 4141830),
	character(472920862, 1979184),
	character(859192376, 7876735),
	character(807338815, 1979184),
	character(520291868, 1979187),
	character(405812031, 789516),
	character(506671902, 1979187),
	character(1043542814, 923696),
	character(789504, 789504),
	character(789504, 101452800),
	character(50727960, 1575942),
	character(4128768, 16128),
	character(806882310, 396312),
	character(405811998, 786444),
	character(2071683902, 1966971),
	character(858988044, 3355455),
	character(1046898239, 4154982),
	character(50554428, 3958275),
	character(1717974559, 2045542),
	character(504776319, 8341014),
	character(504776319, 984598),
	character(50554428, 8152691),
	character(1060320051, 3355443),
	character(202116126, 1969164),
	character(808464504, 1979187),
	character(506881639, 6776374),
	character(101058063, 8349254),
	character(2139060067, 6513515),
	character(2070898531, 6513523),
	character(1667446300, 1848931),
	character(1046898239, 984582),
	character(858993438, 3677755),
	character(1046898239, 6776374),
	character(235352862, 1979192),
	character(202124607, 1969164),
	character(858993459, 4141875),
	character(858993459, 794163),
	character(1801675619, 6518655),
	character(473326435, 6501916),
	character(506671923, 1969164),
	character(405889919, 8349260),
	character(101058078, 1967622),
	character(403441155, 4218928),
	character(404232222, 1972248),
	character(1664490504, 0),
	character(0, -16777216),
	character(1575948, 0),
	character(807272448, 7222078),
	character(1040582151, 3892838),
	character(857604096, 1979139),
	character(1043345464, 7222067),
	character(857604096, 1966911),
	character(252065308, 984582),
	character(862846976, 523255347),
	character(1849034247, 6776422),
	character(202244108, 1969164),
	character(808452144, 506671920),
	character(912655879, 6764062),
	character(202116110, 1969164),
	character(2134048768, 6515583),
	character(857669632, 3355443),
	character(857604096, 1979187),
	character(1715142656, 252067430),
	character(862846976, 2016427571),
	character(1849360384, 984678),
	character(54394880, 2043934),
	character(205392904, 1584140),
	character(858980352, 7222067),
	character(858980352, 794163),
	character(1801650176, 3571583),
	character(912457728, 6501916),
	character(858980352, 523255347),
	character(423559168, 4138508),
	character(118230072, 3673100),
	character(1579032, 1579032),
	character(940313607, 461836),
	character(15214, 0),
	character(0, 0)
);
