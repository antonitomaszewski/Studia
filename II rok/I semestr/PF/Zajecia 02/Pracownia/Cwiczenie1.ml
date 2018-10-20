#directory "/home/nudge/Pulpit/Programowanie Funkcyjne";;
#use "funkcje.ml";;

let f_consuj (x : 'a) (xss : 'a list list) : 'a list list = map (function (xs : 'a list) -> x::xs) xss;;
let f_nieconsuj x xss = map (function xs -> xs) xss;;

(* let f (x : 'a) (xss : 'a list list) : 'a list list =
  map (function (xs : 'a list) -> [xs; x :: xs]) xss;; *)

let rec sublists (xs : 'a list) : 'a list list =
  match xs with
      [] -> [[]]
    | head::tail ->
      let next = sublists tail
      in append next (f_consuj head next);;

sublists [1;2];;
