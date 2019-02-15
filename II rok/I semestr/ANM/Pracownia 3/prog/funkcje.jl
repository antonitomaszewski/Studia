function myzip(xs, ys)
    n = min(length(xs),length(ys))
    return map(i->(xs[i],ys[i]), [i for i in 1:n])
end
function myunzip(xys)
    xs = map(pair -> pair[1], xys)
    ys = map(pair -> pair[2], xys)
    return xs,ys
end