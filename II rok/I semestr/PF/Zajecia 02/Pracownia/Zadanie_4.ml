let rec append xs ys =
  match xs with
  | [] -> ys
  | head::tail -> head :: (append tail ys);;

let rec reverse_iter xs result =
  match xs with
  | [] -> result
  | h :: t -> reverse_iter t (h :: result);;

let partition (pred : 'a -> bool) (xs : 'a list) : ('a list * 'a list) =
  let rec iter  xs (result : 'a list * 'a list) =
    match (xs, result) with
      | ([],(left, right)) -> ((reverse_iter left []),(reverse_iter right []))
      | (head::tail, (left, right)) when (pred head) -> (iter tail (head::left, right))
      | (head::tail, (left, right)) when (not (pred head)) -> (iter tail (left, head::right))
  in iter xs ([],[]);;

(partition (function x -> (x <= 5)) [6;1;0;9;2;3;6;4;5]);;
let rec quicksort (rel : 'a -> 'a -> bool) (xs : 'a list) =
  match xs with
    | [] -> []
    | head::[] -> xs
    | head::tail ->
      let (mniejsze, wieksze) = (partition (function x -> rel x head) tail)
      in (append (quicksort rel mniejsze) (head::(quicksort rel wieksze)));;


quicksort (<=) [5;-1;6;7;3;4;9;8;0;2];;
