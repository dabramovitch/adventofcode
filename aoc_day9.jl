using DelimitedFiles

dats = readdlm("input_day9.dat")

function updatetail(headpos,tailpos)
    if sum((headpos .- tailpos).^2) <= 2
        return tailpos
    else
        displacement = sign.(headpos .- tailpos)
        return tailpos .+ displacement
    end
end

dir2disp = Dict(["U" => [0,1],"D"=>[0,-1],"L"=>[-1,0],"R"=>[1,0]])

function evolvepos(dats)
    headpos = [0,0]
    tailpos = [0,0]
    visited = [tailpos]
    for irow in 1:size(dats,1)
        dir,steps = dats[irow,:]
        disp = dir2disp[dir]
        for istep in 1:steps
            headpos = headpos + disp
            tailpos = updatetail(headpos,tailpos)
            if !(tailpos in visited)
                push!(visited,tailpos)
            end
        end
    end
    return length(visited)
end

function evolvepos_nknots(dats,n)
    knotpos = [[0,0] for i in 1:n]
    visited = [knotpos[end]]
    for irow in 1:size(dats,1)
        dir,steps = dats[irow,:]
        disp = dir2disp[dir]
        for istep in 1:steps
            knotpos[1] = knotpos[1] + disp
            for knot in 2:n
                knotpos[knot] = updatetail(knotpos[knot-1],knotpos[knot])
            end
            if !(knotpos[end] in visited)
                push!(visited,knotpos[end])
            end
        end
    end
    return length(visited)
end

println(evolvepos(dats))
println(evolvepos_nknots(dats,2))
println(evolvepos_nknots(dats,10))
