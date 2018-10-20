(* Zad 1 *)
let fun x = x;
let i n = n + 0;
let int_id_2 n : int = n;
let int_id_3 (n : int) : int = n;

(* let s (a : 'a) : 'b = function x -> x;; *)
let rec f1_zad1 x = f1_zad1 x ;;
let f2_zad1 f g = function x -> (f (g x));;
