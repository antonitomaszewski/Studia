(* let fix =
   !(fun f' ->
     !(fun f -> !(fun x -> f' @ (f @ f) @ x))
     @ !(fun f -> !(fun x -> f' @ (f @ f) @ x))
   ) *)


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
let a = mk_circular_list 1
let a = insert_head 0 a
let a = insert_tail (-1) a
;;
a
;;
