let rec length xs =
  match xs with
    [] -> 0
  | head::tail -> 1 + (length tail);;
length [1;2;21];;

let rec foldl f a = function
    [] -> a
  | head::tail -> foldl f (f a head) tail;;

foldl (+) 0 [8;4;10];;

type complex = { re: float; im: float } ;;
g {x1 = 1; x2 = 'a'; x3 = "b"};;

type 'a list = [] | :: of 'a * 'a list;;
let rec append (xs: ‘a list) (ys: ‘a list) =
  match xs with
      [] -> ys
    | x::xs' -> x :: (append xs' ys);;

(* let [x1;x2] = lst <=> hd, tl *)
