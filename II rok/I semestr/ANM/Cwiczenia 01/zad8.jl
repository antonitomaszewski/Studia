println()
i = Float64(1.0)

while float(i*(float(1/i))) == 1
    global i = nextfloat(i)
end
println(i)
# 1.000000057228997


function nierowne(x = Float64)
    while float(x * float(1/x)) == 1
        x = nextfloat(x)
    end
    return x
end

println(nierowne(1.0))
