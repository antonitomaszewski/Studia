fib = 1:1:(zipWith (+) fib (tail fib))
take 10 fib
