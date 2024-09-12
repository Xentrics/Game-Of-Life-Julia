using Plots, DSP

# main Game of life function loop
function runGoL(GoL; runs=100,  sleepTime=0.02, safeToDisk=false, showOnConsole=true)

    # 2D kernel to update cells        
    Mfilt = [true true  true;
             true false true;
             true true  true]

    # Simulate the game
    for i_gen = 1:runs
      # Perform 2D FFT-based convolution
      convGoL = DSP.conv(GoL, Mfilt)
      lives2 = convGoL .== 2
      lives3 = convGoL .== 3
      
      # Keep only cells with 2 or 3 neighbors alive
      # Make new cells if neighbors are 3
      twoLiveNeig = (GoL .&& lives2[2:end-1, 2:end-1])
      GoL = twoLiveNeig .|| lives3[2:end-1, 2:end-1]
      
      # Safe current frame as image
      #if safeToDisk
      #  plt[:imshow](GoL, interpolation="none")
      #  plt[:savefig]("GoLpics/gen$i_gen.png")
      #end
        
      if showOnConsole
        plot(heatmap(GoL), show=true, reuse=true)
        sleep(sleepTime)
      end
    end

    return(GoL)
end


# Make a simulation grid
function initiate_grid(grid_size_width=384, grid_size_height=384)
    rand(Bool, grid_size_width, grid_size_height)
end


# start a random map
function start(GoL=nothing, runs=100, grid_size_width=384, grid_size_height=384; sleepTime=0.02)
  grid = initiate_grid(grid_size_width, grid_size_height)
  runGoL(grid, runs=1000, sleepTime=sleepTime)
end

# continue last run
#res = runGoL(res)
