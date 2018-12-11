
ones :: [Int]
ones = 1:ones

-- take 5 ones
-- take 5 [30..]

-- [x^2 | x <- [1..5]]

primes :: [Int]
primes = sieve [2..]
  where
     sieve  :: [Int] -> [Int]
     sieve (p:xs) = p:sieve [x| x<-xs, x `mod` p /= 0]

-- take 10 primes
-- takeWhile (<10) primes

fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
-- fibs = 0 : 1 : map (\(a,b) -> a+b) (zip fibs (tail fibs))

tenFibs = take 10 fibs

nats' m = aux 0 m
    where
    aux n m = if m > 0 then n : aux (n+1) (m-1) else []



