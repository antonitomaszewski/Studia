
# P(n) = (1/2)*n*(sin(2*pi/n))

P(n) = pi



function c(n = BigFloat)
    if(n==2)
        return 0
    else
        return BigFloat(sqrt((1/2)*(1+c(n-1))))
    end
end

function s(n = BigFloat)
    if(n==2)
        return 1
    else
        return BigFloat(BigFloat(sqrt((1/2)*(1-c(n-1)))))    end
end

function s2(n = BigFloat)
    if (n==2)
        return 1
    else
        return (BigFloat(s2(2*n)))/(2*(BigFloat(c(n))))
    end
end

A(n = BigFloat) =  BigFloat((2^(n-1))*s(n))

println("ZADANIE 5")

setprecision(128) do
    for i in 2:128
        print(i)
        print("  ")
        print(P(2^i))
        print("  ")
        print(A(i))
        print("  ")
        println(abs(P(2^i) - A(i)))
    end
end
