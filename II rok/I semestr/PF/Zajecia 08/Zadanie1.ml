module type PQUEUE =
sig
  type priority
  type 'a t

  exception EmptyPQueue

  val empty : 'a t
  val insert : 'a t -> priority -> 'a -> 'a t
  val remove : 'a t -> priority * 'a * 'a t
end


module PQueue : PQUEUE with type priority = int =
struct
  type priority = int
  type 'a t = (priority * 'a) list

  exception EmptyPQueue

  let empty : 'a t = []
  let rec insert pq prio elem =
    match pq with
    | ((p,e) :: tl) -> if (prio >= p)
      then (prio, elem) :: pq
      else (p,e) :: insert tl prio elem
    | empty -> [(prio, elem)]
  let remove  pq =
    match pq with
    | ((p,e)::tl) -> (p,e,tl)
    | _ -> raise EmptyPQueue
end


let pqueueSort (xs : int list) : int list =
  let rec create xs =
    match xs with
    | [] -> PQueue.empty
    | h::t -> PQueue.insert (create t) h h
  in let rec uncreate pq =
       try
         match PQueue.remove pq with
         | _, v, nextpq -> v :: (uncreate nextpq)
       with
       | PQueue.EmptyPQueue -> []
  in  List.rev (uncreate (create xs))
;;
let x =  [1;0;1;4;7;6;5;4;2;1;9];;
pqueueSort x;;


















;;
