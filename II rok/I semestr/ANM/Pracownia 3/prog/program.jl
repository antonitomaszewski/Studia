using Polynomials
using Plots
include("funkcje.jl")
return

prec = 0.01
idealne = [(cos(t), sin(t)) for t in -pi:0.001:pi]
return

function makeSpline(coordinates)
    function CalculateCs()
        μ = [NaN64 for k in 1:n]
        α = vcat([0.], [3. * (A[k+1] - A[k])/h[k] - 3. * (A[k] - A[k-1])/h[k-1] for k in 2:n])

        C = [0. for k in 1:nPlus1]
        l = [0. for k in 1:nPlus1]
        z = [0. for k in 1:nPlus1]

        l[1] = 1.
        μ[1] = 0.
        z[1] = 0.

        for k in 2:n
            l[k] = 2 * (xs[k+1] - xs[k-1]) - h[k-1] * μ[k-1]
            μ[k] = h[k] / l[k]
            z[k] = (α[k] - h[k-1]*z[k-1]) / l[k]
        end

        l[nPlus1] = 1.
        z[nPlus1] = 0.
        C[nPlus1] = 0.

        for k in n:(-1):1
            C[k] = z[k] - μ[k]*C[k+1]
        end
        return C
    end
    nPlus1 = length(coordinates)
    n = nPlus1 - 1
    # x1 x2 ... xk+1
    xs = map(pair->pair[1], coordinates)
    # y1 y2 ... yk+1
    # ys = map(pair->pair[2], coordinates)
    A = map(pair->pair[2], coordinates)

    h = [xs[k+1] - xs[k] for k in 1:n]
    C = CalculateCs()

    B = [(A[k+1] - A[k]) / h[k] - h[k]*(C[k+1] + 2. * C[k]) / 3. for k in 1:n]
    D = [(C[k+1] - C[k]) / (3. * h[k]) for k in 1:n]

    outputSet = [Poly(NaN) for k in 1:n]
    intervals = myzip(xs,xs[2:end])

    for k in 1:n
        xk = xs[k]
        polynom = A[k] + B[k]*poly([xk]) + C[k]*(poly([xk])^2) + D[k]*(poly([xk]) ^ 3)
        outputSet[k] = polynom
    end
    return myzip(outputSet, intervals)
end

function calculateSpline(splajn)
#     prec = 0.01
    coors = []
    angles = []

    for i in 1:length(splajn)
        xk = splajn[i][2][1]
        xkPlus1 = splajn[i][2][2]
        wielomian = splajn[i][1]
        przedzial = [x for x in xk:prec:(xkPlus1-prec)]

        coors = vcat(coors, map(wielomian, przedzial))
        angles = vcat(angles, przedzial)
    end

    return angles, coors
end

function circle(n, r = 1)
    ps = [t for t in -pi:2*pi/n:pi]
    xs = r * cos.(ps)
    ys = r * sin.(ps)

    xspline = makeSpline(myzip(ps, xs))
    yspline = makeSpline(myzip(ps, ys))


    angles, xvalues = calculateSpline(xspline)
    angles, yvalues = calculateSpline(yspline) #jak zrobi się na odwrót kolejności to wychodzą ładne rysunki błędów

    xerrors = abs.(cos.(angles) - xvalues)
    yerrors = abs.(sin.(angles) - yvalues)

    errors = sqrt.([x^2 for x in xerrors] + [y^2 for y in yerrors])

    return [(angles, errors), (xvalues, yvalues), (xs, ys)]
end

function plotCircle(c, n)
    plot!(c[2], lab = "n = " * string(n), linestyle = :dash)
#     scatter!(c[3], lab = "Zadane punkty")
end

function mainCircle(ns :: Array{Int})

    Plots.plot(size = (600*1.1, 600))

    title!("Splajn")

    xlabel!("Os x")
    ylabel!("Os y")


    plot!(idealne, lab = "idealne kolo", color = :black)
    cns = [(circle(n), n) for n in ns]
    for cn in cns
        plotCircle(cn[1], cn[2])
    end

    savefig("splajn")
end
function mainCircle(n :: Int)

    Plots.plot(size = (600*1.1, 600))

    title!("Splajn")

    xlabel!("Os x")
    ylabel!("Os y")

    plot!(idealne, lab = "idealne kolo", color = :black)
    c = circle(n)
    plotCircle(c, n)

    savefig("splajn")
end


function plotError(c, n)
    plot!(c[1], lab = "n = " * string(n))
end
function mainError(ns :: Array{Int})
    Plots.plot(size = (600*1.1, 600))

    title!("Splajn Bledy")

    xlabel!("Os x")
    ylabel!("Os y")

    cns = [(circle(n), n) for n in ns]
    for cn in cns
        plotError(cn[1], cn[2])
    end

    savefig("splajnbledy")
end
function mainError(n :: Int)

    Plots.plot(size = (600*1.1, 600))

    title!("Splajn Blad")

    xlabel!("Os x")
    ylabel!("Os y")

    c = circle(n)
    plotError(c, n)

    savefig("splajnblad")
end

function helix(n, p, r = 1)
    ps = [t for t in -pi:pi/n:pi]
    xs = r * cos.(ps)
    ys = r * sin.(ps)

    xspline = makeSpline(myzip(ps, xs))
    yspline = makeSpline(myzip(ps, ys))

    angles, xvalues = calculateSpline(xspline)
    angles, yvalues = calculateSpline(yspline)

    pts = [p*t for t in angles]

    Plots.plot(size = (600*1.1, 600), leg = false)
    plot!(pts, xvalues, yvalues)
    plot!(xvalues, pts, yvalues)
    plot!(xvalues, yvalues, pts)
    title!("Helisa Splajn")
    xlabel!("Os x")
    ylabel!("Os y")
end

function B(t)
    c = (4/3)*(sqrt(2) - 1)

    P0 = [0,1]
    P1 = [c,1]
    P2 = [1,c]
    P3 = [1,0]

    return (1-t)^3*P0 + 3*(1-t)^2*t*P1 + 3*(1-t)*t^2*P2 + t^3*P3
end

function circle()
    n = 1000
    prec = 1/n
    ts = [t for t in 0:prec:1]

    xvalues, yvalues = myunzip([B(t) for t in ts])

    angles = [t for t in 0:pi/(2*n+1):pi/2]

    xerrors = abs.(sin.(angles) - xvalues)
    yerrors = abs.(cos.(angles) - yvalues)

    errors = sqrt.([x^2 for x in xerrors] + [y^2 for y in yerrors])

    xvs = vcat(xvalues, yvalues, -xvalues, -yvalues) #cosinus
    yvs = vcat(-yvalues, xvalues, yvalues, -xvalues) #sinus

    xvalues = xvs
    yvalues = yvs

    return [(angles, errors), (xvalues, yvalues)]
end

function silnia(k)::BigInt
    if k == 0
        return 1
    else
        return k * silnia(k-1)
    end
end

function ilorazysilni(k)::Tuple{Array{BigFloat,1}, Array{BigFloat,1}}
    xis = [BigFloat(1.) for i in 0:k]
    yis = [BigFloat(1.) for i in 0:k]
    xis[1] = yis[1] = BigFloat(1.)
    for j in 2:k
        i = j - 1
        xis[j] = BigFloat(xis[i] * BigFloat(k+i-1) * BigFloat(k - i) / BigFloat(i))
        yis[j] = xis[j] * (k+i) / (k-i)
    end
    yis[k+1] = yis[k] * 2
    return xis, yis
end

function Hk(k, α, facts, e, f)
    suma = .0
    for i in 0:e
        hi = f(pi*(k+i)/2 + α) / (2*α)^(k+i+1)
        fact = facts[i+1]
        suma += (hi*fact)
    end
    return suma / silnia(k)
end

function Xk(k, α)
    return Hk(k, α, ilorazysilni(k)[1], k-1, cos)
end
function Yk(k, α)
    return Hk(k, α, ilorazysilni(k)[2], k, sin)
end

function Hn(t, n, α, Hks, c1, c2)
    suma = .0
    c = t^2 - α^2
    for k in 1:n
        suma += Hks[k]*c^k
    end
    suma *= c1
    suma += c2
    return suma
end

function Xn(t, n, α, Xks)
    return Hn(t, n, α, Xks, 2*α, cos(α))
end
function Yn(t, n, α, Xks)
    return Hn(t, n, α, Xks, 2*t, t*sin(α)/α)
end


function arc(n, α, r)
    Xks = [Xk(k, α) for k in 1:n]
    Yks = [Yk(k, α) for k in 1:n]

    angles = [t for t in -α:prec:α]

    xvalues = r * [Xn(t, n, α, Xks) for t in angles]
    yvalues = r * [Yn(t, n, α, Yks) for t in angles]

    xerrors = abs.(r * cos.(angles) - xvalues)
    yerrors = abs.(r * sin.(angles) - yvalues)

    angles = convert.(Float64, round.(angles; digits = 10))
    xvalues = convert.(Float64, round.(xvalues; digits = 10))
    yvalues = convert.(Float64, round.(yvalues; digits = 10))
    xerrors = convert.(Float64, round.(xerrors; digits = 10))
    yerrors = convert.(Float64, round.(yerrors; digits = 10))

    errors = sqrt.([x^2 for x in xerrors] + [y^2 for y in yerrors])

    return [(angles,errors), (xvalues, yvalues)]
end
function circle(n, α = pi, r = 1)
    a = arc(n, α, r)
    angles, errors = a[1]
    xvalues, yvalues = a[2]

    if α == pi
        xpoints = [cos(pi), cos(-pi)]
        ypoints = [sin(pi), sin(-pi)]
        return [(angles, errors), (xvalues, yvalues), (xpoints, ypoints)]
    end
    if α == pi/2
        xvalues = vcat(xvalues, reverse(-xvalues))
        yvalues = vcat(yvalues, reverse(yvalues))

        xpoints = [cos(pi/2), cos(-pi/2)]
        ypoints = [sin(pi/2), sin(-pi/2)]
        return [(angles, errors), (xvalues, yvalues), (xpoints, ypoints)]
    end
    if α == pi/4
        xvs = vcat(reverse(xvalues), reverse(yvalues), -xvalues, yvalues)
        yvs = vcat(reverse(yvalues), reverse(-xvalues), yvalues, xvalues)
        xvalues = xvs
        yvalues = yvs

        xpoints = [cos(pi/4), cos(3*pi/4), cos(5*pi/4), cos(7*pi/4)]
        ypoints = [sin(pi/4), sin(3*pi/4), sin(5*pi/4), sin(7*pi/4)]

        return [(angles, errors), (xvalues, yvalues), (xpoints, ypoints)]
    end
end

function helix(n, p, α = pi, r = 1)
    Xks = [Xk(k, α) for k in 1:n]
    Yks = [Yk(k, α) for k in 1:n]

    angles = [t for t in -α:prec:α]

    xvalues = r * [Xn(t, n, α, Xks) for t in angles]
    yvalues = r * [Yn(t, n, α, Yks) for t in angles]
    zvalues = [p * t for t in angles]

    return [xvalues, yvalues, zvalues]
end
