let lhead s = List.hd s;;
let ltail s = (List.tl  s) ();; (* czy  (List.tl s ()) *)

let rec s n = if (n=0) then (lhead s) else ((ltail s) (n-1));;

let rec map f s = (f (lhead s)) :: (function () -> (map f (ltail s)));;
let rec map2 f s1 s2 = (f (lhead s1) (lhead s2)) :: (function () -> (map2 f (ltail s1) (ltail s2)));;
let add s n = (map (function x -> x+n) s);;

let rec replace_iter s n i a =
  if (i=1)
    then a :: function () -> (replace_iter (ltail s) n n a)
    else lhead s :: function () -> (replace_iter (ltail s) n (n-1) a);;
let replace s n a = replace_iter s n n a;;

let rec take_iter s n i =
  if (i=1)
    then lhead s :: function () -> (take_iter (ltail s) n n)
    else take_iter (ltail s) n (i-1);;
let take s n = take_iter s n n ;;

(* zawsze wybieram (lhead s) i do dalszego wywołania wybieram (ltail s) *)
let rec scan (f : 'a -> 'b -> 'a) (a : 'a) (s : 'a list) =
  let head = lhead s
  head :: function () -> (scan f head (ltail s));;

let rec tabulate s ?(i=0) j =
  if (j= -1)
    then []
    else if (i=0)
      then lhead s :: function () -> (tabulate (ltail s) 0 (j-1))
      else tabulate (ltail s) (i-1) (j-1);;


(*
(* Zad 4 *)
let lcons x f = (x,f);;
let lhead l = fst l;;
let ltail l = ((snd l) ());;

let rec nats_from n =
  lcons
    n
    (function () -> (nats_from (n+1)));;

let rec add l n =
  (lcons ((lhead l) + n)
    (function () -> (add (ltail l) n)));;
    *)
