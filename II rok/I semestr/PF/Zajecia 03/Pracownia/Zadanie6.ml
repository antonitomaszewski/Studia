let isprime n =
  let rec check i =
    if i*i > n
    then true
    else if n mod i = 0
    then false
    else check (i+2);
  in
  if (n = 2)
  then true
  else if (n = 0) || (n = 1) || ((n mod 2) = 0)
  then false
  else check 3;;

let rec nats s e =
  if (s>e)
  then []
  else e:: (nats s (e-1));;
let rec member x xs =
  match xs with
  | [] -> false
  |h::t when x=h -> true
  |_::t -> member x t;;

let rec isalwayscomplex xs =
  match xs with
  | [] -> true
  | ((h1,h2), p)::t->  ((not (isprime h1)) || (not (isprime h2))) && (isalwayscomplex t);;

let subsum sum =
  List.rev (List.map (fun n -> ((n,sum-n), sum)) (nats 2 ((sum-1)/2)));;
let p_from_subsum sum =
  match sum with
  | ((m,n),s) -> (m*n, ((m,n), s));;

subsum 10;;
List.map p_from_subsum (subsum 10);;

let subsums_from_p_from_subsum pss =
  List.map (fun (p, sum) -> subsum p) pss;;

subsums_from_p_from_subsum (List.map p_from_subsum (subsum 10));;

let goodsubsum subsump =
  (isalwayscomplex subsump);;

let good_subsums_ subsums =
  List.map goodsubsum subsums;;
let isgood subsumes =
  (List.length (List.filter (fun n -> n) (good_subsums_ subsumes))) = 1;;

let go sum =
  subsums_from_p_from_subsum (List.map p_from_subsum (subsum sum));;
let spr sum =
  isgood (go sum);;

List.map (fun n-> n,(spr n)) (nats 2 100);;


(*
let s = subsum 10;;
let ps = List.map p_from_subsum s;;
let sps = subsums_from_p_from_subsum ps;;
(* let good_subsums_ sps;; *)
List.map goodsubsum sps;;
List.filter (fun n -> n) [false; false; false];; *)


subsum 17;;
List.map p_from_subsum (subsum 17);;
subsums_from_p_from_subsum (List.map p_from_subsum (subsum 17));;
good_subsums_ (subsums_from_p_from_subsum (List.map p_from_subsum (subsum 17)));;
