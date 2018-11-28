(* Zadanie 1 *)
let rec fix (f : ('a -> 'b) -> 'a -> 'b) (x : 'a) = f (fix f) x

let fac = fix (fun f -> fun n -> if n=0 then 1 else n * (f (n-1)))

let fix (f : ('a -> 'b) -> 'a -> 'b) =
  let r = ref (fun x -> x)
  in let fix_ f' n = f !r n
  in r := fix_ f;
  !r
let fact =
  fix (fun f -> fun n -> if n = 0 then 1 else n * (f (n - 1)))
;;
(* fact 0;; *)
print_string "z refami\n";
for i = 0 to 10 do
  print_int i;
  print_string " -> ";
  print_int (fact i);
  print_newline ()
done
;;
print_string "z let rec\n";
for i = 0 to 10 do
  print_int i;
  print_string " -> ";
  print_int (fac i);
  print_newline ()
done
;;



(* Zadanie 2 *)
type 'a list_mutable = LMnil | LMcons of 'a * 'a list_mutable ref

let rec concat_copy (xs : 'a list_mutable) (ys : 'a list_mutable) =
  match xs with
  | LMnil -> ys
  | LMcons(x, tl) -> LMcons(x,ref (concat_copy (!tl) ys))

let rec concat_share xs ys =
  match xs with
    LMnil -> ys
  | _ -> let rec set_last xs' =
           match xs' with
           | LMcons(_, tl) when (!tl) = LMnil -> tl := ys
           | LMcons(_, tl) -> set_last (!tl)
           | LMnil -> failwith "fejkowy match"
    in set_last xs; xs

let a = (LMcons(1,ref (LMcons(2, ref LMnil))))
let b = concat_copy (a) (a)
let b2 = concat_share a a
;;





(* Zadanie 3 *)

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



(* Zadanie 4 *)
let (fresh, reset) =
  let r = ref 0
  in let fre =
       fun (x : string) -> r := !r + 1;
         x ^ (string_of_int !r)
  in let res i = r := i
  in fre, res
;;
fresh "x"
;;
fresh "x"
;;
reset 7
;;
fresh "x"

;;
fresh "a"
;;


(* Zadanie 5 *)
type 'a lnode = {item: 'a; mutable next: 'a lnode}
let mk_circular_list e =
  let rec x = {item=e; next=x}
  in x
let insert_head e l =
  let x = {item=e; next=l.next}
  in l.next <- x; l
let insert_tail e l =
  let x = {item = e; next = l.next}
  in l.next <- x; x

let remove_head cykl = cykl.next <- (cykl.next.next)
let cmake n =
  let cykl = mk_circular_list n
  and p = ref (n-1)
  in while !p > 0 do
    insert_tail !p cykl;
    p := (!p-1)
  done;
  cykl
let rec cnth cykl n =
  match n with
  | 0 -> cykl
  | _ -> cnth (cykl.next) (n-1)
let jozek n m : int list =
  let cykl = cmake n
  in let rec jozek_ n cykl =
       match n with
       | 0 -> []
       | _ -> let cykl' = cnth cykl (m-1)
         in let mth_val = cykl'.next.item
         in  mth_val:: (remove_head cykl'; (jozek_ (n-1) cykl'))
  in jozek_ n cykl
;;
jozek 7 2 ;;
jozek 7 3 ;;
jozek 7 4 ;;
jozek 7 5 ;;
jozek 7 6 ;;
