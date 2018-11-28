type 'a array = MemNil | Pair of 'a keyval * 'a array ref and
  'a keyval = KeyVal of 'a * 'a

let empty () =  MemNil
let rec find k (arr: 'a array) =
  match arr with
  | MemNil -> (false, 0)
  | Pair(KeyVal(k1, v1), arr) ->
    if (k1 = k)
    then (true, v1)
    else find k !arr

let rec add (k,v) (arr : 'a array) =
  match arr with
  | MemNil -> Pair(KeyVal(k,v), ref MemNil)
  | Pair(_) -> Pair(KeyVal(k,v), ref arr)
  (* let rec add (k,v) (arr : 'a array ref ) =
     let x = arr
     in       arr := Pair(KeyVal(k,v), x) *)


;;
let fib_memo (n : int) =
  let arr = ref (empty ())
  in
  arr := add (1,1) !arr
  ;
  arr := add (2,1) !arr
  ;
  let rec fib_memo_ n =
    match find n !arr with
    | (false, _) -> let fib_1 = fib_memo_ (n-1) and fib_2 = fib_memo_ (n-2)
      in let fib = fib_1 + fib_2
      in arr := add (n, fib) (!arr); fib
    | (true, fib) -> fib
  in
  let res = fib_memo_ n
  in res
let rec fib n =
  if (n < 3)
  then 1
  else (fib (n-1)) + (fib (n-2))
;;
let time f x =
  let t = Sys.time() in
  let fx = f x in
  Printf.printf "Execution time: %fs\n" (Sys.time() -. t);
  fx;;
fib_memo 1;;
time fib_memo 40;;
time fib 40;;
;;
