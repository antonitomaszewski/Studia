let correct m =
  let l = List.length m
  in (List.filter (function r -> (List.length r) <> l) m) = [];;

let correct2 m =
  (fun l0 -> (List.for_all (fun r -> (List.compare_length_with r l0) = 0) m)) (List.length m);;

let column_n m n =
  List.map (fun r -> (List.nth r n))  m;;

let nats n =
  let rec _nats n xs =
    if n=(-1)
    then xs
    else _nats (n-1) (n::xs)
  in _nats n [];;

let transpose m =
  List.map (fun n -> column_n m n) (nats ((List.length (List.hd m)) -1));;

let rec zip xs ys =
  match (xs, ys) with
  | ([],[]) -> []
  | (hx::tx, hy::ty) -> (hx,hy) :: (zip tx ty);;


let zipf (f : 'a * 'b -> 'c) (xs: 'a list) (ys: 'b list) =
  List.map f (zip xs ys);;

let mv m v =
  List.map (fun r -> (List.fold_left (+) 0 (zipf (fun (x,y) -> x*y) r v))) m;;

let ab a b =
  transpose (List.map (fun v -> mv a v) (transpose b));;
