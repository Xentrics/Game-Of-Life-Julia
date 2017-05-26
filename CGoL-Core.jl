
using PyPlot



#GoL = rand(Bool,500,500)
#GoL = rand([0.0, 1.0], 500, 500)
function runGoL(GoL=nothing; runs=100, sleepTime=0.01, safeToDisk=false, showOnConsole=true)
    Mfilt = [true true  true; true  false  true; true true true]
    
    if GoL == nothing
        GoL = rand(Bool,500,500)
    end
    
    plt[:axis]("off")
    im = plt[:imshow](GoL, interpolation="none")
    for i_gen = 1:runs
        convGoL = conv2(GoL, Mfilt)
        lives2 = convGoL .== 2
        lives3 = convGoL .== 3

        twoLiveNeig = (GoL & lives2[2:end-1,2:end-1]) 
        GoL = twoLiveNeig | lives3[2:end-1,2:end-1]
        
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

runGoL(nothing)




