# Game-Of-Life-Julia
Game of Life by Conway in Julia

This is based on the code of [byrddev/CGoL](https://github.com/byrddev/CGoL).

I made some minor improvements to the code. But most importantly, I found a way to make fluid, graphical output without the 
need of saving images. I use the matplotlib library of Python, but update the data of the plot directly.
The syntax in julia looks a bit awkward first, but it has do to with the native Python call mechanics of Julia.
