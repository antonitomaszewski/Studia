type 'a number = ('a -> 'a) -> 'a -> 'a;;

let zero (f : 'a -> 'a) (x : 'a) = x;;
let succ n = fun (f : 'a -> 'a) (x : 'a) -> f(n f x);;
let isZero (n : 'a number) = n (function z -> false) true;;

let add (a : 'a number) (b : 'a number) : 'a number = fun (f : 'a -> 'a) (x : 'a) -> (a f (b f x));;
let mult (a : 'a number) (b : 'a number) : 'a number = function x -> a (b x);;

let church_to_int (n : 'a number) : int = n (function x -> x + 1) 0;; (* n jest n krotnym złożeniem churcha, więc po prostu n razy dodam 1 do 0 *)
let rec int_to_church (n : int) : 'a number = if (n = 0) then zero else succ(int_to_church(n-1));; (* dopóki nie dojdę do n=0 dokładam nakładam na zero succ, mamy więc succ(succ ... (succ zero))...) *)

let one = succ(zero);;
let two = add one one;;
let three = add one two;;
church_to_int (mult one two);;
church_to_int (mult two two);;
church_to_int (three);;

let five = int_to_church 5;;
(* isZero five;;  jak dam tutaj to on uważa five za (int->int) -> int -> int i ma błąd typów, więc używam wyłącznie do tych które zrobiłem samemu z zero, a nie z i2c(n) *)
church_to_int (add five two);;
isZero zero;;
isZero (succ zero);;
