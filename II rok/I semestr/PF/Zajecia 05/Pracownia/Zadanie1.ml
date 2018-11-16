type 'a llist = LNil | LCons of 'a * (unit -> 'a llist);;
let lhd = function
    LNil -> failwith "lhd"
  | LCons (x, _) -> x;;
let ltl = function
    LNil -> failwith "ltl"
  | LCons (_, xf) -> xf();;

let rec lfrom k = LCons (k, function () -> lfrom (k+1));;
let rec ltake = function
    (0,_) -> []
  | (_, LNil) -> []
  | (n, LCons(x,xf)) -> x::ltake(n-1, xf());;
ltake (5,lfrom 40);;

(* let sign n = if n>0. then 1. else -1.;;
   let rec lpi' k = LCons (1./.k, function () -> lpi' (-1. *. (sign k) *. ((abs_float k) +. 2.)));;
   let lpi = lpi' 1.;;
   ltake (10,(lpi' 1.));;

   let rec accum (stream : 'a llist) acc zeroVal n =
   match (stream, n) with
   | (LNil,_) -> zeroVal
   | (_, 0) -> zeroVal
   | (LCons(x, xf),_) -> acc x (accum (xf()) acc zeroVal (n-1));;

   let calculatePi n = 4. *. (accum lpi (+.) 0. n);;
   calculatePi 10000;; *)




let proc (xk : float) (k : int) =
  let sign = if (k mod 2 = 0) then (-.) else (+.)
  in sign xk (1. /. (float_of_int (2 * k - 1)));;

proc (proc 1. 2) 3;;
let rec npi k xk = LCons(xk, function () -> npi (k+1) (proc xk k));;
List.map (fun v -> 4. *. v) (ltake (100, npi 2 1.));;

let rec transform f (stream : 'a llist)=
  let LCons(x1, xf1) = stream
  in let LCons(x2, xf2) = xf1()
  in let LCons(x3, xf3) = xf2()
  in LCons ((f x1 x2 x3), function () -> transform f (xf1()));;

ltake (10, transform (fun a b c -> a+b+c) (lfrom 1));;

let t x y z = z -. ((y -. z) *. (y -. z)) /. (x -. 2. *. y +. z);;
let rec newPi = transform t (npi 2 1.);;
List.map (fun v -> 4. *. v) (ltake (10, newPi));;
