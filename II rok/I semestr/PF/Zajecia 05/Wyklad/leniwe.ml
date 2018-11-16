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

let rec (@$) ll1 ll2 =
  match ll1 with
    LNil -> ll2
  | LCons(x,xf) -> LCons (x, function () -> (xf()) @$ ll2);;

let rec toLazyList xd =
  match xd with
  | [] -> LNil
  | x::xs -> LCons(x, function () -> toLazyList xs);;
(* ltake (5, (toLazyList [1;3;5;7;8;9;0]));; *)
