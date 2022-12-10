f = open("input_day6.dat")

l = readline(f)

ndistinct = 14
for (ic,c) in enumerate(l)
    if ic >= ndistinct && length(unique(l[ic-ndistinct+1:ic])) == ndistinct
        println(c,l[ic-ndistinct:ic-1],typeof(c),typeof(l[ic-ndistinct:ic-1]))
        println(ic)
        break
    end
end
