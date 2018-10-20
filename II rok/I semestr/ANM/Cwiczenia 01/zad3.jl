function w(x = Float16)
    return x*x*x - 6*x*x + 3*x - 0.149
end
function w1(x = Float32)
    return x*x*x - 6*x*x + 3*x - 0.149
end
function w2(x = Float64)
    return x*x*x - 6*x*x + 3*x - 0.149
end

function z(x = FLoat16)
    return ((x-6)*x+3)*x-0.149
end
function z1(x = FLoat32)
    return ((x-6)*x+3)*x-0.149
end
function z2(x = FLoat64)
    return ((x-6)*x+3)*x-0.149
end

wy = Float16(-14.636489)
wy1 = Float32(-14.636489)
wy2 = Float64(-14.636489)

x = Float16(4.71)
x1 = Float32(4.71)
x2 = Float64(4.71)

println((w(x) - wy2) / wy2)
println((w1(x1) - wy2) / wy2)
println((w2(x2) - wy2) / wy2)

println((z(x) - wy2) / wy2)
println((z1(x1) - wy2) / wy2)
println((z2(x2) - wy2) / wy2)
