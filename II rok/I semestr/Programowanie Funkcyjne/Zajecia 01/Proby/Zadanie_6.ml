(*
type 'a church = ('a -> 'a) -> 'a -> 'a;;
let zero : 'a church = fun f x -> x;;
let succ n : 'a church = fun f x -> f (n f x);;
let add (a:'a church) b = a succ b;;
*)

let zero = function f -> function x -> x;;
let succ = (function n -> (function f -> (function x -> f(n (f) (x)))));;
let one = succ(zero);;
let isZero = function n -> (n (function z -> false) true);;

let add = function a -> function b -> function f -> function x -> a(f)(b(f)(x));;
let mult = function a -> function b -> function f -> function x -> b(a(f))(x);;

(* let add2 = function a -> function b -> function f -> function x -> b(f(x))(a (x));; *)
let mult2 = function a -> function b -> function x -> a(b(x));;

let church_to_int = function n -> n(function x -> x + 1)(0);; (* n jest n krotnym złożeniem churcha, więc po prostu n razy dodam 1 do 0 *)
let rec int_to_church = function n -> if (n = 0) then zero else succ(int_to_church(n-1));;


zero;;
one;;
succ one;;

isZero zero;;
isZero one;;

let three = int_to_church(3);;
let two = int_to_church(2);;
let one = int_to_church(1);;

church_to_int(mult two three);;
church_to_int(add one three);;
isZero(zero);;
isZero(succ zero);;

church_to_int(mult2 two three);;
(* church_to_int(add2 two three);; *)

succ zero;;
isZero(succ (succ zero));;

let add3 a b = (b succ) a;;
let mult3 a b = (b (add a)) zero;;
let one = succ zero;;
let two = succ one;;
let three = succ two;;
church_to_int(add3 (succ zero) (succ (succ zero)));;
church_to_int(add3 (succ (succ zero)) (succ (succ zero)));;
