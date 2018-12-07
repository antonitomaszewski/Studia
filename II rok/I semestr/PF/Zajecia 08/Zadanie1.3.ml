module type PQUEUE =
sig
  type priority
  type 'a t

  exception EmptyPQueue

  val empty : 'a t
  val insert : 'a t -> priority -> 'a -> 'a t
  val remove : 'a t -> priority * 'a * 'a t
end

module type ORDTYPE =
sig
  type t
  type comparision = LT | EQ | GT

  val compare : t -> t -> comparision
end

module PQueue (OrdType : ORDTYPE) : PQUEUE with type priority = OrdType.t =
struct
  type priority = OrdType.t
  type 'a t = (priority * 'a) list

  exception EmptyPQueue

  let empty : 'a t = []
  let rec insert pq prio elem =
    match pq with
    | [] -> (prio, elem) :: empty
    | (p,e)::pqs ->
      match OrdType.compare prio p with
      | OrdType.LT -> (p,e) :: (insert pqs prio elem)
      | OrdType.EQ
      | OrdType.GT -> (prio,elem) :: pq

  let remove  pq =
    match pq with
    | ((p,e)::tl) -> (p,e,tl)
    | _ -> raise EmptyPQueue

end




module OrdInt : ORDTYPE with type t = int =
struct
  type t = int
  type comparision = LT | EQ | GT

  let compare a b =
    if a<b
    then LT
    else if a=b
    then EQ
    else GT
end
module PQInt = PQueue(OrdInt)

;;

let pqueueSort xs =
  let module PQ = PQueue(OrdInt)
  in let rec create xs =
       match xs with
       | [] -> PQ.empty
       | x::xs' -> PQ.insert (create xs') x x
  in let rec uncreate pq =
       try
         match PQ.remove pq with
         | _, v, nextpq -> v :: (uncreate nextpq)
       with
       | PQ.EmptyPQueue -> []
  in List.rev (uncreate (create xs))

let x = [8;5;6;3;2;1;8;9;9;88]
;;
pqueueSort x;;


let pqueueSort4 (type a) (module Ord : ORDTYPE with type t = a) (xs : a list) : a list=
  let module PQ = PQueue(Ord)
  in let rec create xs =
       match xs with
       | [] -> PQ.empty
       | x::xs' -> PQ.insert (create xs') x x
  in let rec uncreate pq res =
       try
         match PQ.remove pq with
         | _, v, nextpq -> (uncreate nextpq (v :: res))
       with
       | PQ.EmptyPQueue -> res
  in uncreate (create xs) []
;;
pqueueSort4 (module OrdInt) x;;










;;
