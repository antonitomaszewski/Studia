type 'a btree = Leaf | Node of 'a btree * 'a * 'a btree;;

let rec balanced_ (tree : 'a btree) =
  match tree with
    Leaf -> (true, 0)
  | Node(tl, v, tr) ->
    match ((balanced_ tl), (balanced_ tr)) with
    | ((true, nl), (true, nr)) when (abs(nl - nr) <= 1) -> (true, (nl + 1 + nr))
    | (_,_) -> (false, 0);;
let balanced tree = fst (balanced_ tree);;

balanced Leaf;;
balanced (Node(Leaf, 0, Node(Leaf, 1, Node(Leaf, 2, Node(Leaf,3,Node(Leaf,4,Leaf))))));;

let rec halve xd len =
  match (xd, len) with
  | (_,0) -> ([], xd)
  | (h::t,_) ->
    let (left,right) = halve t (len-1)
    in (h::left, right);;

let rec revPreorder_ xd len =
  match xd with
  | [] -> Leaf
  | h::t ->
    let half = len/2
    in let (left, right) = halve t half
    in Node((revPreorder_ left half), h, (revPreorder_ right ((len-1)/2)));;

let revPreorder xd = revPreorder_ xd (List.length xd);;

halve [1;2;3;4] 2;;
revPreorder [];;
List.length [1];;
revPreorder [1];;
revPreorder [1;2];;
revPreorder [1;2;3];;
revPreorder [1;2;3;4;5;6];;


let rec factTree_ tree f =
  match tree with
  | Leaf -> (f 1)
  | Node(tleft, n, tright) ->
    if n=0
    then 0
    else factTree_ tleft (fun v -> (factTree_ tright (fun v2 -> f (v * v2 * n))));;
(* else factTree_ tleft (fun v -> n * v * (factTree_ tright f));; *)
let factTree tree = factTree_ tree (fun v -> v);;

factTree (revPreorder []);;
factTree (revPreorder [2]);;
factTree (revPreorder [1;2;3]);;
factTree (revPreorder [1;2;3;4;5]);;
factTree (revPreorder [5;4;3;1;0]);;
