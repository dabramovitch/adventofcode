using DataStructures

stacks = [Stack{Char}() for i in 1:9]
startingcrates = ["NWFRZSMD","SGQPW","CJNFQVRW","LDGCPZF","SPT","LRWFDH","CDNZ","QJSVFRNW","VWZGSMR"]

for (i,crates) in enumerate(startingcrates)
    for crate in reverse(crates)
        push!(stacks[i],crate)
    end
end

mode = 9001
if mode == 9000
    for line in readlines(open("input_day5.dat"))[11:end]
        howmany,from,to = parse.(Int64,split(line,' ')[[2,4,6]])
        for i in 1:howmany
            push!(stacks[to],pop!(stacks[from]))
        end
    end
elseif mode == 9001
    for line in readlines(open("input_day5.dat"))[11:end]
        howmany,from,to = parse.(Int64,split(line,' ')[[2,4,6]])
        pickedup = Stack{Char}()
        for i in 1:howmany
            push!(pickedup,pop!(stacks[from]))
        end
        for i in 1:howmany
            push!(stacks[to],pop!(pickedup))
        end
    end
end
println(prod([first(stack) for stack in stacks]))
