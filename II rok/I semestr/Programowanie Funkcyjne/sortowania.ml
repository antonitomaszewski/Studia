#use "funkcje.ml";;

let partition (pred : 'a -> bool) (xs : 'a list) : ('a list * 'a list) =
  let rec _partition  xs (result : 'a list * 'a list) =
    match (xs, result) with
      | ([],(left, right)) -> ((_reverse left []),(_reverse right []))
      | (head::tail, (left, right)) when (pred head) -> (_partition tail (head::left, right))
      | (head::tail, (left, right)) when (not (pred head)) -> (_partition tail (left, head::right))
  in _partition xs ([],[]);;

let rec quicksort (rel : 'a -> 'a -> bool) (xs : 'a list) =
  match xs with
    | [] -> []
    | head::[] -> xs
    | head::tail ->
      let (mniejsze, wieksze) = (partition (function x -> rel x head) tail)
      in (append (quicksort rel mniejsze) (head::(quicksort rel wieksze)));;



let rec halve xs result =
  match (xs, result) with
  | ([],_) -> result
  | (h1::h2::t, (left,right)) -> halve t (h1::left, h2::right)
  | (h1::[], (left,right)) -> (h1::left, right);;

let rec merge (xs : 'a list) (ys : 'a list) (rel : 'a -> 'a -> bool) (result : 'a list) =
  match (xs, ys) with
    | ([], []) -> result
    | ([],_) -> (_reverse ys result)
    | (_,[]) -> (_reverse xs result)
    | (hx::tx, hy::ty) ->
      if (rel hx hy)
        then merge tx ys rel (hx::result)
        else merge xs ty rel (hy::result);;

let notrel rel = (fun x y -> not (rel x y));;
let rec _mergesort xs rel =
  match xs with
    | [] -> []
    | x::[] -> xs
    | _  ->
  let (left, right) = (halve xs ([],[]))
  in merge (_mergesort left (notrel rel)) (_mergesort right (notrel rel)) rel [];;

let mergesort (xs : 'a list) (rel : 'a -> 'a -> bool) : 'a list =
  _mergesort xs (notrel rel);;
