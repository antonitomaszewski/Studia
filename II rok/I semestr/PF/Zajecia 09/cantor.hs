ntaPrzekatna x y n = zipWith (,) (take n x) (reverse (take n y))

ntaPrzekatna [1..] [1..] 3

cantor x y n = concat [(ntaPrzekatna x y n),(cantor x y (n+1))]
-- (ntaPrzekatna [1..] [1..] 1) ++ (ntaPrzekatna [1..] [1..] 2) ++ (ntaPrzekatna [1..] [1..] 3)
cant x y = cantor x y 0
take 10 (cant [1..] [1..])
take 10 (cant [1..5] [6..10])

nta x' y' = zipWith (,) x' y'
kant x y x' y' = concat [(nta x' y'), (kant (tail x) (tail y) (x' ++ [head x]) ([head y] ++ y'))]

take 10 (kant [1..] [1..] [] [])
take 10 (kant [1..5] [6..10] [] [])
