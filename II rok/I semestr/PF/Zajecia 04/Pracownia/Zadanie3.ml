type 'a mtree = MNode of 'a * 'a forest and 'a forest = EmptyForest | Forest of 'a mtree * 'a forest;;

let breadth1 mtree =

