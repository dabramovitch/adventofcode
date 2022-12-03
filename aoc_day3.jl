using DelimitedFiles

dats = readdlm("input_day3.dat",String)

const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

function lettervalue(l::Char)
    lint = Int64(l)
    if lint >= 97 && lint < 97+26
        return lint - 96
    elseif lint >= 65 && lint < 65+26
        return lint - 64 + 26
    end
end 

function repeatedchar(s1::AbstractString,s2::AbstractString)
    for c1 in s1
        if contains(s2,c1)
            return c1
        end 
    end 
end

function repeatedchar(s1::AbstractString,s2::AbstractString,s3::AbstractString)
    return letters[findall(l -> contains(s1,l) && contains(s2,l) && contains(s3,l),letters)[1]]
end

"""
Help the elves! 
"""
function totalvalues(dats)
    total = 0
    for s in dats
        total += lettervalue(repeatedchar(s[1:end÷2],s[end÷2+1:end]))
    end
    return total 
end

println(totalvalues(dats))

function totalvalues2(dats)
    total = 0
    for i in 1:size(dats,2)
        total += lettervalue(repeatedchar(dats[1,i],dats[2,i],dats[3,i]))
    end 
    return total
end

println(totalvalues2(reshape(dats,3,length(dats) ÷ 3)))
