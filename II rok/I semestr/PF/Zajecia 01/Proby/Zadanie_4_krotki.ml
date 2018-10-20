(* type 't stream = 't * (unit -> 't stream);;  cykliczy typ error ??!?!?!? *)
type 't fstream = 't -> 't;;

let lhead (s : 't * 'f) = fst s;;
let ltail (s : 't * 'f) = (snd s) ();;

(* let rec s (n : int) : 't = if (n=0) then (lhead s) else ((ltail s) (n-1));; *)

let rec map (f : 't -> 't)  (s : 't * 'f) =
  (f (lhead s)) , (function () -> (map f (ltail s)));;
let rec map2 f s1 s2 = (f (lhead s1) (lhead s2)) , (function () -> (map2 f (ltail s1) (ltail s2)));;
let add s n = (map (function x -> x+n) s);;

let rec replace_iter s n i a =
  if (i=1)
    then a , function () -> (replace_iter (ltail s) n n a)
    else lhead s , function () -> (replace_iter (ltail s) n (n-1) a);;
let replace s n a = replace_iter s n n a;;

let rec take_iter s n i =
  if (i=1)
    then lhead s , function () -> (take_iter (ltail s) n n)
    else take_iter (ltail s) n (i-1);;
let take s n = take_iter s n n ;;

(* zawsze wybieram (lhead s) i do dalszego wywołania wybieram (ltail s) *)
let rec scan (f : 'a -> 'b -> 'a) (a : 'a) (s : 'a list) =
  let head = lhead s
  head , function () -> (scan f head (ltail s));;

let rec tabulate s ?(i=0) j =
  if (j= -1)
    then []
    else if (i=0)
      then lhead s , function () -> (tabulate (ltail s) 0 (j-1))
      else tabulate (ltail s) (i-1) (j-1);;
