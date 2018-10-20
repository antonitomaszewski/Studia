
(* let t () = fun x -> fun y -> x;;
((t() 1 0) = 1);;
let f () = fun x -> fun y -> y;;
((f() 1 0) = 1);; *)

let ctrue = function x -> function y -> x;;
let cfalse = function x -> function y -> y;;


(*
let cand = function x -> function y -> x (y x) ;;
let cor = function x -> function y -> x (x y) ;; (* typ jak dla zero *) *)

let and1 = fun p q -> p q cfalse;;
let or1 = fun p q -> p ctrue q;;


(* let cbool_to_bool = (function a -> function b -> function c -> c (a(b))) (true) (false);; *)

let church_to_bool = function c -> c true false;;
let bool_to_church = function b -> if b then ctrue else cfalse;;

church_to_bool ctrue;;
church_to_bool (bool_to_church false);;

(* church_to_bool(cand ctrue cfalse);; *)

church_to_bool(or1 ctrue cfalse);;
church_to_bool(and1 ctrue cfalse);;
