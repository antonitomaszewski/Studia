let f1 x = x 2 2;;
(* (int -> int -> a) -> a *)
let f2 x y z = x (y ^ z);;
(* (string -> a) -> string -> string -> a *)
let f3 x y z = x y z;;
(* (a -> b -> c) -> a -> b -> c *)
let f4 x y = function z -> x::y;;
(* a -> a list -> b -> a list *)
