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
