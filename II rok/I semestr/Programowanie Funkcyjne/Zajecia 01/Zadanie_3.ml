(* Zad 3 *)
let compose f g = function x -> (f (g x));;
let rec repeated f n =
  if (n=0)
    then function x -> x
    else (compose f (repeated f (n-1)));;

let mult a b = (repeated ((+) a) b) 0;; (* b razy dodaję do 0 a *)

let power a b = (repeated (mult a) b) 1;; (* b razy domnażam do jedynki a *)

mult 3 4;;
power 2 5;;
