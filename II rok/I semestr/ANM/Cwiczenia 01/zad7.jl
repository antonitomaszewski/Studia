println()
# k = -3
# while k < 10
    # println(k, " = " , bitstring(Float64(k)))
    # global k += 1
# end

# println(bitstring(0.5))

function bin2dec(s)
    x = 0
    for c in s
        x *= 2
        x += Int(c) - Int('0')
    end
    return x
end

function stringbit2num(s)
    bias = 2^10 - 1
    sign = bin2dec(s[1])
    ex = bin2dec(s[2:12]) - bias
    mant = 1 + bin2dec(s[13:end]) / (2^52)
    if sign == 1
        sign = -1
    else
        sign = 1
    end
    return sign * mant * (2^ex)
end

# println(stringbit2xber(bitstring(1)))
bitstring(stringbit2num(1.0))
