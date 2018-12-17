function VectorToList(args)
    res = []
    for t in args
        res = vcat(res, t)
    end
    return res
end
function myzip(xs, ys)
    n = min(length(xs),length(ys))
    return map(i->(xs[i],ys[i]), [i for i in 1:n])
end
function myunzip(xys)
    xs = map(pair -> pair[1], xys)
    ys = map(pair -> pair[2], xys)
    return xs,ys
end
function makeInterval(xstart, xend, stepp = 0.01)
    return [x for x in xstart:stepp:xend]
end
