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
let rec lmap f stream =
  match stream with
  | LNil -> LNil
  | LCons(x, xf) -> LCons(f x, function () -> lmap f (xf()));;








type move = FILL of int | DRAIN of int | TRANSFER of int * int;;
type state = int list * int list;;
FILL 1;;


(* let fill (n : int) (glasses : int list) *)
(* let nsols ((glasses, volume) : (int list * int)) (n : int) : move list list *)

(* let f = nsols (g, v) in (f n; f n);; *)

let rec fill (n : int) ((gl, vl) : state) : int list=
  match (n, (gl, vl)) with
  | (0, (g::gs, v::vs)) -> g::vs
  | (_, (g::gs, v::vs)) -> let vd = fill (n-1) (gs, vs) in v::vd
  | _ -> vl;;
fill 0 ([4;9], [0;6]);;

let rec drain (n : int) ((gl, vl) : state) : int list =
  match (n, (gl, vl)) with
  | (0, (g::gs, v::vs)) -> 0::vs
  | (_, (g::gs, v::vs)) -> let vd = drain (n-1) (gs, vs) in v::vd
  | _ -> vl;;
drain 0 ([4;9], [4;6]);;

let rec transferDo ((n,m) : int*int) (v : int) (vl : int list) : int list=
  match ((n,m), vl) with
  | (_, []) -> []
  | ((0,_), vn::vs) -> (vn-v)::(transferDo (n-1,m-1) v vs)
  | ((_,0), vm::vs) -> (vm+v)::(transferDo (n-1,m-1) v vs)
  | (_, vk::vs) -> vk::(transferDo (n-1,m-1) v vs);;
transferDo (0,1) 3 [4;6];;

let transfer ((n,m) : int * int) ((gl, vl) : state) : int list =
  let vn = List.nth vl n and vm = List.nth vl m and gm = List.nth gl m
  in if vn+vm > gm
  then transferDo (n,m) (gm-vm) vl
  else transferDo (n,m) vn vl;;


let makeMove (m : move) (s : state) : int list =
  match m with
  | FILL n -> fill n s
  | DRAIN n -> drain n s
  | TRANSFER (n, m) -> if n=m then snd s else transfer (n,m) s;;
makeMove (TRANSFER (0,1)) ([4;9],[4;6]);;


let generateMoves (len : int) =
  let rec indecies = function
      (0,rest) -> 0::rest
    | (n,rest) -> indecies ((n-1), n::rest)
  in let inds = indecies (len-1, [])
  in (List.map (fun i -> FILL i) inds) @
     (List.map (fun i -> DRAIN i) inds) @
     (List.map (fun (i,j) -> TRANSFER (i,j)) (List.flatten (List.map (fun i -> (List.map (fun j -> (i,j)) inds)) inds)));;

generateMoves (2);;


let nsols ((gl, vol) : int list * int) (n : int) : move list list=
  let allMoves = toLazyList (generateMoves (List.length gl))
  and vl = List.map (fun g -> 0) gl
  and isOk vl = List.mem vol vl
  in

  let history = []
  and stream = fun () -> LNil
  in

  let start = LCons((vl, history), stream)

  in let rec iter = function
      | LCons((vl, historyOfMoves), stream) ->
        if (isOk vl)
        then LCons(List.rev historyOfMoves, function () -> iter (stream ()))
        else (iter ((stream()) @$ (lmap (fun move -> ((makeMove move (gl, vl)), move::historyOfMoves)) allMoves)))
      | LNil -> LNil
  in ltake (n, (iter start));;

nsols ([1;2], 2) 2;;
nsols ([4;9], 5) 5;;
(* transfer (1,2) ([1;2;4], [0;2;1]);;
   drain 3 ([1;2;3;4], [1;2;3;4]);; *)
