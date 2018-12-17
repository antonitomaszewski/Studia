using Polynomials
using Plots
include("funkcje.jl")


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




function findRoot(polyn, c)
    interval = polyn[2]
    xk = interval[1]
    xkPlus1 = interval[2]
    polynomial = polyn[1]

    rooty = roots(polynomial - c)
    filter!(z -> imag(z) == 0., rooty)
    rooty = map(z -> real(z), rooty)

    filter!(x -> xk <= x <= xkPlus1, rooty)
    return rooty
end

function findRoots(splines, c)
    Rootki = map(p -> findRoot(p,c), splines)
    filter!(r -> length(r) != 0, Rootki)
    return Rootki
end

function PlotMain(coor, splajn, pierwiastki, c, a, b, name, prec = 0.01)
    function PlotSpline()
        xs = []
        ys = []
        # ysPrim = []
        # ysPrimPrim = []
        for i in 1:length(splajn)
            xk = splajn[i][2][1]
            xkPlus1 = splajn[i][2][2]
            wielomian = splajn[i][1]
            xs = vcat(xs, [x for x in xk:prec:xkPlus1])
            ys = vcat(ys, map(wielomian, [x for x in xk:prec:xkPlus1]))
            # ysPrim = vcat(ysPrim, map(polyder(wielomian), [x for x in xk:prec:xkPlus1]))
            # ysPrimPrim = vcat(ysPrimPrim, map(polyder(polyder(wielomian)), [x for x in xk:prec:xkPlus1]))
        end
        plot!(plotka, xs, ys, lab = "Naturalna funkcja sklejana s(x)", linecolor=:blue)
        # plot!(plotka, xs, ysPrim, lab = "Naturalna funkcja sklejana s'(x)", linecolor=:green)
        # plot!(plotka, xs, ysPrimPrim, lab = "Naturalna funkcja sklejana s''(x)", linecolor=:black)
    end
    function PlotRoots()
        scatter!(plotka, pierwiastki, map(x->c, pierwiastki), lab = "Pierwiastki równania f(x) = c", color=:orange, markersize = 11)
    end
    function PlotC()
        plot!(plotka, [a,b], [c,c], lab = "y=c",  linecolor=:black, linewidth=5)
    end
    function PlotF()
        xs, ys = myunzip(coor)
        scatter!(plotka, xs, ys, lab = "Zadane punkty (x,f(x))", color=:green)
    end

    plotka = plot(legend = :topright)
    xlabel!(plotka, "Os x")
    ylabel!(plotka, "Os y")
    title!(string("Wykres s(x), y=c, pierwiastków s(x) = y", name))
    PlotSpline()
    PlotRoots()
    PlotC()
    PlotF()
    display(plotka)
    savefig(plotka, name)
end

function main(coor, c, name="")
    coor = sort(coor)
    splajn = makeSpline(coor)
    pierwiastki = VectorToList(findRoots(splajn, c))

    a = coor[1][1]
    b = coor[end][1]

    PlotMain(coor, splajn, pierwiastki, c, a, b, name)
    return pierwiastki
end
