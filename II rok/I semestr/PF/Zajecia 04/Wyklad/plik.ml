type kolor = Trelf | Karo | Kier | Pik;;
type karta = Blotka of kolor * int | Walet of kolor | Dama of kolor | Krol of kolor | As of kolor;;
let k1 = Krol Pik and k2 = Blotka(Karo, 2);;

let rec przedzial a b = if a>b then [] else b::(przedzial a (b-1));;
let wszystkieKarty kol =
  let figury = [As kol; Krol kol; Dama kol; Walet kol]
  and blotki = List.map (function n -> Blotka(kol,n)) (przedzial 2 10)
  in figury @ blotki;;
let kiery = wszystkieKarty Kier;;

type ('a, 'b) ab = A of 'a | B of 'b;;

let ls = ["Ala ";"ma ";"kota"] and lint = [1;2;3];;

let lsint = (List.map (function x -> A x) ls) @ (List.map (function x -> B x) lint);;

let rec concat_and_add xd =
  match xd with
    [] -> ("", 0)
  | h::t -> match (h, concat_and_add t) with
    | (A str, (s,n)) -> (str^s, n)
    | (B num, (s,n)) -> (s, num+n);;
concat_and_add lsint;;

type 'a nestedList = Nil
                   | NN of 'a nestedList * 'a nestedList
                   | N of 'a * 'a nestedList;;

let rec flatten = function
    Nil -> []
  | NN(xl,xr) -> (flatten xl) @ (flatten xr)
  | N(x, xr) -> x::(flatten xr);;

type 'a bt = Empty | Node of 'a * 'a bt * 'a bt;;
let t = Node(1,
             Node(2,
                  Empty,
                  Node(3,
                       Empty,
                       Empty)),
             Empty);;

let rec nodes = function
    Empty -> 0
  | Node(_,tl,tr) -> 1 + (nodes tl) + (nodes tr);;
nodes t;;

let tt = Node(1,
              Node(2,
                   Node(4,
                        Empty,
                        Empty),
                   Empty),
              Node(3,
                   Node(5,
                        Empty,
                        Node(6,
                             Empty,
                             Empty)),
                   Empty));;

let breadth t =
  let rec breadth_aux = function
      [] -> []
    | Empty::t -> breadth_aux t
    | Node(e, tl, tr)::t -> e::(breadth_aux (t @ [tl; tr]))
  in breadth_aux [t];;
breadth t;;
breadth tt;;

let rec preorder = function
    Node(v, l, r) -> v :: (preorder l) @ (preorder r)
  | Empty -> [];;

preorder tt;;

let preorder' t =
  let rec preorder_ = function
      (Empty, labels) -> labels
    | (Node(v, tl, tr), labels) -> v :: (preorder_ (tl, (preorder_ (tr, labels))))
  in preorder_ (t, []);;
preorder' tt;;


let rec list2bst l =
  let rec insert2bst = function
      (k, Node(r, left, right)) ->
      if k<r then Node(r, insert2bst(k,left), right)
      else if k>r then Node(r,left,insert2bst(k,right))
      else failwith "duplicated string"
    | (k, Empty) -> Node(k, Empty, Empty)
  in match l with
    h::t -> insert2bst (h, list2bst t)
  | [] -> Empty
;;
list2bst [6;4;9;2;5];;

type ('a, 'b) bt = Leaf of 'a | Node of 'b * ('a, 'b) bt * ('a, 'b) bt;;
let rec nrOfLeaves: ('a, 'b) bt -> int =
  function
    Leaf _ -> 1
  | Node (_,left,right) -> nrOfLeaves left + nrOfLeaves right;;

let t1 =
  Node ('*', Node('+', Leaf 2, Leaf 3), Node ('/', Leaf 9, Leaf 3));;
nrOfLeaves t1;;

type kolor = Trefl | Karo | Kier | Pik;;
type 'a tree = Leaf of 'a | Branch of 'a tree * 'a tree;;

Trefl < Kier;;
min Pik Karo;;
Leaf 4 < Branch (Leaf 0, Leaf 1);;
Branch (Leaf 0, Leaf 2) <= Branch (Leaf 0, Leaf 1);;

type bool = false | true;;
not true;;
(* not (true:bool);; *)
not;;

(* Karo < Leaf 1;; *)

type t1 = A | B;;
let f1 x = if x=A then A else A;;
f1 A;;
type t2 = A | C;;
let f2 x = if x=A then A else A;;
f2 A;;
f1 A;;
f1 (f2 A);;
f2 (f1 A);;
