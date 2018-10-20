(* Zadanie 2 *)

let square (x : float) : float = x*.x;;
let cube (x : float) : float = x*.x*.x;;
let goodenough (x : float) (e : float) : bool = abs((cube x) -. a) <= e*.abs(a);;
let better (x : float) : float = x +. ((a /. (square x)) -. x) /. 3.;;
let rec root3iter (x : float) (e : float) : float =
  if (goodenough x e)
    then x
    else (root3iter (better x) e);;
let root3 (a : float) (e : float) : float =
  if a < 1. then (root3iter a e) else (root3iter (a/.3.) e);;
