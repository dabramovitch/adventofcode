using DelimitedFiles

dat = readdlm("input_day1.dat",skipblanks = false)

elftotals::Vector{Int64} = []
thiself::Int64 = 0
for i in dat
    global thiself
    if isa(i,Int64)
        thiself += i
    else
        push!(elftotals,thiself)
        thiself = 0
    end
end 

println(maximum(elftotals))

println(sum(sort(elftotals,rev=true)[1:3]))
