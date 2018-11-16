type 'a bllist = LNil | LCons of 'a * 'a bllist lazy_t

let blhd = function
    LNil -> failwith "blhd"
  | LCons(x,_) -> x
let bltl = function
    LNil -> failwith "bltl"
  | LCons(_,xf) -> Lazy.force xf
let rec blfrom k = LCons (k, lazy (blfrom(k+1)))
let rec bltake = function
    (0,_)
  | (_,LNil) -> []
  | (n, LCons(x,lazy xf)) -> x::(bltake(n-1,xf))

let proc (xk : float) (k : int) =
  let sign = if (k mod 2 = 0) then (-.) else (+.)
  in sign xk (1. /. (float_of_int (2 * k - 1)))

let rec bnpi k xk = LCons(xk, lazy (bnpi (k+1) (proc xk k)));;

let btransform f (stream : 'a bllist) =
  let rec btransform_ f x1 x2 x3 stream =
    LCons(f x1 x2 x3, lazy (btransform_ f x2 x3 (blhd stream) (bltl stream)))
  in let x1 = blhd stream and stream = bltl stream
  in let x2 = blhd stream and stream = bltl stream
  in let x3 = blhd stream and stream = bltl stream
  in btransform_ f x1 x2 x3 stream

let t x y z = z -. ((y -. z) *. (y -. z)) /. (x -. 2. *. y +. z)

let rec newPi = btransform t (bnpi 2 1.)

;;
List.map (fun v -> 4. *. v) (bltake (10, newPi));;
