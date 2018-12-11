-- insert x []     = [[x]]
-- insert x (y:ys) = (map (\xs -> y:xs) (insert x ys))
-- insert x ys = if (ys == []) then [[x]] else [x:ys] ++ (map (\xs -> (head ys):xs) (insert x (tail ys)))
-- iperm xs =
--         if (xs == [])
--                 then [xs]
--                 else insert (head xs) (iperm (tail xs))
--
--
-- main = insert 1 [2,3,4]


-- sublist :: [a] -> [[a]]
-- sublist []     = [[]]
sublist xs = if xs==[] then [[]] else concatMap (\ys -> [(head xs):ys,ys]) (sublist (tail xs))

length (sublist [1..8])
