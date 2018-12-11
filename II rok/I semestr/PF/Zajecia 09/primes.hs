-- divides :: Int -> Int -> Bool
-- divides a b = mod a b == 0

f (p:xs) = filter (\x -> (mod x p) /= 0) xs
primes = map head (iterate f [2..])

take 20 primes

-- primes' :: [Integer]

all p = foldr ((&&) . p) True
takeWhile p = foldr (\ x xs -> if p x then x:xs else []) []
primes' = 2:(filter (\p -> all (\q -> mod p q /= 0) (takeWhile (\q -> q*q <= p) primes')) [3..])
take 20 primes'
