type 'a place = 'a list * 'a list;;

let findNth (xd : 'a list) (n : int) : 'a place =
  let rec findNth_ prev next n =
    match (next, n) with
    | (_, 0) -> (prev, next)
    | (h::t,_) -> findNth_ (h::prev) t (n-1)
  in findNth_ [] xd n;;

findNth [1;2;3;4;5] 3;;

let collapse (pl : 'a place) : 'a list =
  let rec collapse_ left right =
    match left with
    | [] -> right
    | h::t -> (collapse_ t (h::right))
  in collapse_ (fst pl) (snd pl);;
collapse (findNth [1;2;3;4;5] 3);;

let add (a : 'a) (pl : 'a place) =
  let (left, right) = pl
  in (left, a::right);;
let del (pl : 'a place) =
  let (left, h::right) = pl
  in (left, right);;

collapse (add 3 (findNth [1;2;4] 2));;
collapse (del (findNth [1;2;4] 2));;
del (add 0 (findNth [1;2;3;4] 2));;
let next (pl : 'a place) : 'a place=
  let (left, h::right) = pl
  in (h::left, right);;
next (findNth [1;2;3;4] 2);;
let prev (pl : 'a place) : 'a place =
  let (h::left, right) = pl
  in (left, h::right);;
prev (findNth [1;2;3;4] 2);;

(* type 'a btplace = Leaf  *)
