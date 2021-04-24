# Epoch-Shader
 noun: epoch; a particular period of time in history or a person's life.

BUFFER USAGE:
- colortex0
    Writes: composite0-2
    Reads: composite0-2
    Effects: N/A
    Holds: Main screen
- colortex1
    Writes: composite1
    Reads: composite1
    Effects: Interlacing
    Holds: Main screen, a frame behind
- colortex2
    Writes: composite2
    Reads: composite2
    Effects: Ghosting
    Holds: Accumulated mains screen
- colortex3
    Writes: shaders.properties
    Reads: composite2
    Effects: texture-based CRT mode
    Holds: CRT RGB texture