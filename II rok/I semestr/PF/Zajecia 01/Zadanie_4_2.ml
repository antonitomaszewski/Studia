let identity n = n;;

let hd s = s(0);;
let tl s = function n -> s(n+1);;

let add s a = function n -> s(n) + a;;
let map s f = function n -> f (s(n));;
let map2 s1 s2 f = function n -> f s1(n) s2(n);;

let replace s n a = function k -> if (k mod n = 0) then a else s(k);;

let take s n = function k -> s(n*k);;

let rec scan s f a = function n -> if (n=0) then (f a s(0)) else (f ((scan s f a) n-1) s(n));;

take identity 2 10;;
hd identity;;
add identity 9 2;;
map identity (function n -> n * n) 3;;


(*
let rec tab_iter s i j k =
  if (k>j)
    then []
    else s(k) :: (tab_iter s i j k+1);;
    *)

(* let tabulate s ?(i=0) j = tab_iter s i j i;; *)
