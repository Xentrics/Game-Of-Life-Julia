
# if ASCI terminal style if preferred
function printGoL(GoL)
    # Clear the terminal and move cursor to the top
    print("\e[H\e[2J")

    # Loop through the matrix and print each cell as a character
    for row in eachrow(GoL)
        for cell in row
            # Print a character depending on the value (true or false)
            print(cell ? "*" : " ")  # You can use any symbols you prefer
        end
        println()  # Move to the next line after each row
    end
end

