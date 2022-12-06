using DelimitedFiles

toints(str) = parse.(Int64,split(str,'-'))
dats = toints.(readdlm("input_day4.dat",',',String))

containedtotal = 0
overlaptotal = 0
for ipair in 1:size(dats,1)
    global containedtotal,overlaptotal
    range1,range2 = dats[ipair,:]
    containedtotal += (range1[1] <= range2[1] && range1[2] >= range2[2]) || (range2[1] <= range1[1] && range2[2] >= range1[2])
    overlaptotal += (range1[1] <= range2[1] && range1[2] >= range2[1]) || (range2[1] <= range1[1] && range2[2] >= range1[1])
end
println(containedtotal," ",overlaptotal)
