(* Zadanie 1 *)
let rec fib1 (n : int) =
  match n with
    0 -> 0
  | 1 -> 1
  | _ -> fib1(n-2) + fib1(n-1);;

let fib2 (n : int) =
  let rec fib2_iter (a : int) (b : int) (i : int) : int =
    if i=n
      then b
      else (fib2_iter (a+b) a (i+1))
  in fib2_iter 1 0 0;;

let rec iter n f x next =
  if n=0
    then []
    else (f x) :: (iter (n-1) f (next x) next);;
iter 10 fib2 0 (function n -> n+1);;
iter 10 fib1 0 (function n -> n+1);;

(* fib1 42;; *)
fib2 42;;



let root3 (a : float) (epsilon : float) : float =
  let cube = (function y -> y*.y*.y);
  let goodEnough x =
    abs((cube x) -. a) <= epsilon*.abs(a);
  let better x =
    x +. ((a/.((function y -> y*.y) x) x)/.3);
  let rec iter x =
    if goodEnough x
      then x
      else iter (better x)
  in iter (if (a < 1) then a else (a/.3))
  ;;
