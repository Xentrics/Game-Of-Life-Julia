# Game-Of-Life-Julia
Game of Life by Conway in Julia

This code is based on the code of [byrddev/CGoL](https://github.com/byrddev/CGoL).

I made some minor improvements to the code. 
Most importantly, I found a way to make 2D convolutions fast (using FFT implementations from DSP) as well as fluid, graphical output without the need of saving images.
