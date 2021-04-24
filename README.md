# Epoch
## /ˈiːpɒk,ˈɛpɒk/
**noun:**
	a particular period of time in history or a person's life.
	*"the Victorian epoch"*

#### Features include
- Scanlines
- Chroma Subsampling
- Depth of Field
- B&W and Color film modes
- Among many others!

![2021-04-24_23 47 55](https://user-images.githubusercontent.com/22845656/115974876-db9a6a80-a557-11eb-8b29-b5a40c35a700.png)
![2021-04-24_23 49 12](https://user-images.githubusercontent.com/22845656/115974863-c7566d80-a557-11eb-8d0f-ed69ce0e9405.png)

### BUFFER USAGE:
- colortex0
    - Writes: composite0-2
    - Reads: composite0-2
    - Effects: N/A
    - Holds: Main screen
- colortex1
    - Writes: composite1
    - Reads: composite1
    - Effects: Interlacing
    - Holds: Main screen, a frame behind
- colortex2
    - Writes: composite2
    - Reads: composite2
    - Effects: Ghosting
    - Holds: Accumulated mains screen
- colortex3
    - Writes: shaders.properties
    - Reads: composite2
    - Effects: texture-based CRT mode
    - Holds: CRT RGB texture
