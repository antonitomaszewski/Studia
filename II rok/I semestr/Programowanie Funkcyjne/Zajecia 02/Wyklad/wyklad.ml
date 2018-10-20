(* pattern matching *)
let l = ["A"; "b"; "cc"];;
let [x1; x2; x3] = l;;
let h::t = l;;

let (z,_) = (false,10);;

let x = (("Smith",27),true);;
let ((n,w),b) = x;;

let imply1 pb =
  match pb with
      (true, true) -> true
    | (true, false) -> false
    | (false, true) -> true
    | (false, false) -> true;;
let imply2 pb =
  match pb with
      (true, x) -> x
    | (false, x) -> true;;
let imply3 pb =
  match pb with
    (true, x) -> x
    | (false, _) -> true;;
let imply4 pb =
  match pb with
      (true, false) -> false
    | _ -> true;;
let imply5 =
  function
      (true, false) -> false
    | _ -> true;;
let (=>) b1 b2 =
  match (b1, b2) with
      (true, false) -> false
    | _ -> true;;
(* # false => true;;
- : bool = true *)

let rec zip pl =
(* zip ([x1, ... ,xn], [y1, ... ,yn]) = [(x1,y1), ... ,(xn,yn)] *)
  match pl with
      (h1::t1,h2::t2) -> (h1,h2)::zip(t1,t2)
    | _ -> [];;
let rec unzip ps =
(* unzip [(x1,y1), ... ,(xn,yn)] = ([x1, ... ,xn], [y1, ... ,yn]) *)
  match ps with
      [] -> ([], [])
    | (h1,h2)::t -> let (l1,l2) = unzip t in (h1::l1, h2::l2);;

let xs = [1;2];;
let ys = xs;;
let xs = [0,2];;
ys;;

let ys = let (h::t) = xs in h::t;;

(* identyfikator symboliczny, można wywoływać infiksowo --> (@) l1 l2 lub l1 @ l2 *)
(* append *)
let rec ( @ ) l1 l2 =
  match l1 with
      [] -> l2
    | hd :: tl -> hd :: (tl @ l2)
let xs = [1;2] and ys = [3;4]
  let zs = xs @ ys;;


let rec badAppend l1 l2 =
  match (l1,l2) with
  | ([],[]) -> []
  | ([],h2::t2) -> h2::badAppend [] t2
  | (h1::t1,[]) -> h1::badAppend t1 []
  | (h1::t1,h2::t2) -> h1::badAppend t1 l2;;
let xs = [1;2] and ys = [3;4]
  let zs = badAppend xs ys;;

let x = (("Smith",27),true);;
let ((n,w) as l,b) = x;;

let f1 = fun ((x,y),z) -> (x,y,(x,y),z);;
let f2 = fun ((x,y) as p,z) -> (x,y,p,z);;

let rec sqr_list l =
  match l with
    [] -> []
  | h::t -> h*h :: sqr_list t;;
