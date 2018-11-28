type 'a lnode = {item: 'a; mutable next: 'a lnode}
let mk_circular_list e =
  let rec x = {item=e; next=x}
  in x
let insert_head e l =
  let x = {item=e; next=l.next}
  in l.next <- x; l
let insert_tail e l =
  let x = {item = e; next = l.next}
  in l.next <- x

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
         in remove_head cykl'; mth_val::(jozek_ (n-1) cykl')
  in jozek_ n cykl
;;
jozek 7 2 ;;
jozek 7 3 ;;
jozek 7 4 ;;
jozek 7 5 ;;
jozek 7 7 ;;


























;;
