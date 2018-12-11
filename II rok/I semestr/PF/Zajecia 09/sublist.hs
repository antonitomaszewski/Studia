sublist xs = if xs==[] then [[]] else concatMap (\ys -> [(head xs):ys,ys]) (sublist (tail xs))

length (sublist [1..8])
