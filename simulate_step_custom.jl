using Plots, DSP, ArrayPadding

# a single game of life step with custom rules & border folding
function step_fold(GoL, al_min=2, al_max=3, new_min=3, new_max=3)

    # 2D kernel to update cells        
    Mfilt = [true true  true;
             true false true;
             true true  true]
    
    # Add a border mirroring 'the other side' of the matrix
    GoL2 = pad(GoL, :periodic, 1)
    
    # Perform 2D FFT-based convolution
    convGoL = DSP.conv(GoL2, Mfilt)
    stay_alive = (convGoL .>= al_min  .&& convGoL .<= al_max )
    born_new   = (convGoL .>= new_min .&& convGoL .<= new_max)

    # Keep only cells with 2 (or 3) neighbours alive
    # Make new cells if neighbours are 3
    twoLiveNeig = (GoL .&& stay_alive[3:end-2, 3:end-2])
    GoL = twoLiveNeig .|| born_new[3:end-2, 3:end-2]
    
    return(GoL)
end


# a single game of life step with custom rules
function step_custom(GoL, al_min=2, al_max=3, new_min=3, new_max=3)

    # 2D kernel to update cells        
    Mfilt = [true true  true;
             true false true;
             true true  true]
    
    # Perform 2D FFT-based convolution
    convGoL = DSP.conv(GoL, Mfilt)
    stay_alive = (convGoL .>= al_min  .&& convGoL .<= al_max )
    born_new   = (convGoL .>= new_min .&& convGoL .<= new_max)

    # Keep only cells with 2 (or 3) neighbours alive
    # Make new cells if neighbours are 3
    twoLiveNeig = (GoL .&& stay_alive[2:end-1, 2:end-1])
    GoL = twoLiveNeig .|| born_new[2:end-1, 2:end-1]
    
    return(GoL)
end


# main Game of life function loop
function runGoL_custom(GoL; runs=100, al_min=2, al_max=3, new_min=3, new_max=3, sleepTime=0.02, fold=true, safeToDisk=false, showOnConsole=true)

    # Simulate the game
    for i_gen = 1:runs
        
        if fold
            GoL = step_fold(GoL, al_min, al_max, new_min, new_max)
        else
            GoL = step_custom(GoL, al_min, al_max, new_min, new_max)
        end
        
        if showOnConsole
            plot(heatmap(GoL), show=true, reuse=true)
            sleep(sleepTime)
        end
    end

    return(GoL)
end


# start a random map
function start_custom(GoL=nothing, runs=100, grid_size_width=384, grid_size_height=384; al_min=2, al_max=3, new_min=3, new_max=3, sleepTime=0.02)
    grid = initiate_grid(grid_size_width, grid_size_height)
    runGoL_custom(grid, runs=runs, al_min=al_min, al_max=al_max, new_min=new_min, new_max=new_max, sleepTime=sleepTime)
end

