using DelimitedFiles
import Base.show

mutable struct Dir
    name::String
    superdir::Union{Dir,Nothing}
    pathto::String
    files::Vector{Tuple{String,Int64}}
    subdirs::Vector{Dir}
end

show(io::IOContext,dir::Dir) = dir.name

const base = Dir("/",nothing,"",[],[])
const dirdict = Dict{String,Dir}("/" => base)

existsin(dir::Dir,directory::Dir) = dir == Dir || any([existsin(dir,subdir) for subdir in directory.subdirs])
existsin(f::AbstractString,directory::Dir) = any([i[1] == f for i in directory.files]) || any([existsin(f,subdir) for subdir in directory.subdirs])
exists(x::Union{Dir,AbstractString}) = existsin(x,base)
sizeof(dir::Dir) = sum([i[2] for i in dir.files],init = 0) + sum([sizeof(subdir) for subdir in dir.subdirs],init = 0)
sumdirsbelowsize(dir::Dir,size::Integer) = (sizeof(dir) <= size ? sizeof(dir) : 0) + sum([sumdirsbelowsize(subdir,size) for subdir in dir.subdirs],init = 0)

dats = readdlm("input_day7.dat")

function initdirectories!(dats)
    currentdir = base
    for il in 1:size(dats,1)
        line = dats[il,:]
        println(line)
        if line[1:2] == ["\$","cd"]
            println("cd ", line[3])
            if line[3] == "/"
                currentdir = base
            elseif line[3] == ".."
                currentdir = currentdir.superdir == nothing ? currentdir : currentdir.superdir
            else
                currentdir = dirdict[currentdir.pathto * "/" * line[3]]
            end
        elseif line[1:2] == ["\$","ls"]
            println("ls")
            continue
        elseif line[1] == "dir"
            newdirname = line[2]
            println("dir ", newdirname)
            if !(newdirname in keys(dirdict))
                newdir = Dir(newdirname,currentdir,currentdir.pathto * "/" * newdirname,[],[])
                push!(currentdir.subdirs,newdir)
                push!(dirdict, newdir.pathto => newdir)
            end
        elseif isa(line[1],Integer)
            filename = line[2]
            println("file ", filename)
            if !(existsin(filename,currentdir))
                push!(currentdir.files, (filename,line[1]))
            end
        end
    end
end

initdirectories!(dats)
println(sizeof(base))
println(sumdirsbelowsize(base,100000))
sizes = [(dir.name,sizeof(dir)) for dir in values(dirdict)]
const diskspace = 70000000
const updatespace = 30000000
usedspace = sizeof(base)
neededspace = updatespace - (diskspace - usedspace)
println(sort([size for size in sizes if size[2]  >= neededspace],by = size -> size[2])[1])
