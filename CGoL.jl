
using Images,PyPlot



#GoL = rand(Bool,500,500)
#GoL = rand([0.0, 1.0], 500, 500)
function runGoL(GoL=nothing; runs=100, sleepTime=0.01, safeToDisk=false, showOnConsole=true, unsafe=false)
    if unsafe
        Mfilt = [1.0 for x in 1:3, y in 1:3]
    else
        Mfilt = [true true  true; true  false  true; true true true]
    end
    
    if GoL == nothing
        if unsafe
            GoL = rand([0.0, 1.0], 500, 500)
        else
            GoL = rand(Bool,500,500)
        end
    end
    
    plt[:axis]("off")
    im = plt[:imshow](GoL, interpolation="none")
    for i_gen = 1:runs
        if unsafe
	    #NOTE: convert to array of double again?
            convGoL = imfilter(GoL, Mfilt, "circular") # much, much faster! And circular :)
	    GoL = GoL .== 1.0 # convert to bool matrix
            lives2 = convGoL .== 2.0
            lives3 = convGoL .== 3.0

            twoLiveNeig =    (GoL & lives2) 
            GoL = twoLiveNeig | lives3
        else
            convGoL = conv2(GoL, Mfilt)
            lives2 = convGoL .== 2
            lives3 = convGoL .== 3

            twoLiveNeig = (GoL & lives2[2:end-1,2:end-1]) 
            GoL = twoLiveNeig | lives3[2:end-1,2:end-1]
        end
        
        if safeToDisk
            imgplot = imshow(GoL, interpolation="none")
            savefig("GoLpics/gen$i_gen.png")
        end
        
        if showOnConsole
            im[:set_data](GoL)
            plt[:draw]()
            sleep(sleepTime)
        end
    end
end

# at the command prompt of where the files are stored
# ffmpeg -r 15 -f image2 -s 800x600 -i gen%d.png -vcodec libx264 -crf 20 CGoL.mp4

runGoL(nothing, unsafe=true)




