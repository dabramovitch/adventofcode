stringtoints(str::AbstractString) = [parse(Int64,i) for i in str]

dats = Matrix(hcat(stringtoints.(readlines(open("input_day8.dat")))...)')
visible = zeros(Bool,size(dats))

# from left
for irow in 1:size(dats,1)
    rowmax = 0
    for icol in 1:size(dats,2)
        height = dats[irow,icol]
        if height > rowmax || icol == 1
            rowmax = height
            visible[irow,icol] = true
        end
    end
end

# from right
for irow in 1:size(dats,1)
    rowmax = 0
    for icol in 0:size(dats,2)-1
        height = dats[irow,end - icol]
        if height > rowmax || icol == 0
            rowmax = height
            visible[irow,end - icol] = true
        end
    end
end

# from top
for icol in 1:size(dats,2)
    colmax = 0
    for irow in 1:size(dats,1)
        height = dats[irow,icol]
        if height > colmax || irow == 1
            colmax = height
            visible[irow,icol] = true
        end
    end
end

# from bottom
for icol in 1:size(dats,2)
    colmax = 0
    for irow in 0:size(dats,1)-1
        height = dats[end - irow,icol]
        if height > colmax || irow == 0
            colmax = height
            visible[end - irow,icol] = true
        end
    end
end

function calcscenicscore(irow,icol,dats)
    treeheight = dats[irow,icol]
    rows,cols = size(dats)
    leftscore,rightscore,upscore,downscore = 0,0,0,0
    disp = 0
    while icol - 1 - disp > 0
        disp += 1
        if dats[irow,icol-disp] >= treeheight break end
    end
    leftscore = disp
    disp = 0
    while icol + 1 + disp <= cols
        disp += 1
        if dats[irow,icol+disp] >= treeheight break end
    end
    rightscore = disp
    disp = 0
    while irow - 1 - disp > 0
        disp += 1
        if dats[irow-disp,icol] >= treeheight break end
    end
    upscore = disp
    disp = 0
    while irow + 1 + disp <= cols
        disp += 1
        if dats[irow+disp,icol] >= treeheight break end
    end
    downscore = disp
    disp = 0
    return leftscore*rightscore*upscore*downscore
end

scenicscores = [calcscenicscore(irow,icol,dats) for irow in 1:size(dats,1), icol in 1:size(dats,2)]

println(sum(visible))
println(maximum(scenicscores))
