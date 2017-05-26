# Game-Of-Life-Julia
Game of Life by Conway in Julia

This is based on the code of [byrddev/CGoL](https://github.com/byrddev/CGoL).

I made some minor improvements to the code. But most importantly, I found a way to make fluid, graphical output without the 
need of saving images. I use the matplotlib library of Python, but update the data of the plot directly.
The syntax in julia looks a bit awkward first, but it has do to with the native Python call mechanics of Julia.

## Note
There are two version. The **core** version simply updates the code by byrddev.
The others use 2D discrete fourier transformation (with circular convolution). This is not just faster, is also make the evolution of the grid more interesting (edges are not truncated). However, there seem to be problems with Julia certain and floating points FFT. Kernels started from the Jupyter notebook through "unssafe operation" error (or similar). Within a normal Julia terminal, this doesn't happen.
