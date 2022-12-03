using DelimitedFiles
using LinearAlgebra,SparseArrays

playkey = Dict(["A"=> 1,"B"=>2,"C"=>3,"X"=> 1,"Y"=>2,"Z"=> 3])

dats = readdlm("input_day2.dat")

score1(play::AbstractString) = playkey[play]
score1(play::Integer) = play

winner(play1::AbstractString,play2::AbstractString) = det(sparse([1,2,3,3,3],[playkey[play1],playkey[play2],1,2,3],[1,1,1,1,1]))

beat(x::Int64) = mod(x,3) + 1
loseto(x::Int64) = mod(x-2,3)+1
tie(x::Int64) = x


function calcscore(dats)
    totalscore = 0
    for idat in 1:size(dats,1)
        totalscore += score1(dats[idat,2]) + 3*(1+winner(dats[idat,1],dats[idat,2]))
    end
    return totalscore
end

function calcscore2(dats)
    totalscore = 0
    stratkey = Dict(["X"=>loseto,"Y"=> tie,"Z"=>beat])
    outcomekey = Dict(["X"=> -1, "Y" => 0, "Z" => 1])

    for idat in 1:size(dats,1)
        play = stratkey[dats[idat,2]](playkey[dats[idat,1]])
        totalscore += score1(play) + 3*(outcomekey[dats[idat,2]]+1)
    end
    return totalscore
end
println(calcscore2(dats))

