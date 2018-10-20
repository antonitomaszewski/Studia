(* Zad 2 *)
let rec f1 n =
  match n with
     0 -> 0
    |n -> 2 * (f1 (n-1)) + 1;;

let rec f2_iter result n =
  if (n = 0)
    then result
    else f2_iter (2*result+1) (n-1);;
let f2 n = f2_iter 0 n;;

f1 60;;
f2 60;;
