module type VERTEX =
sig
  type t
  type label

  val equal : t -> t -> bool
  val create : label -> t
  val label : t -> label
end

(* Podpunkt 1 *)
module type EDGE =
sig
  type label
  type vertex
  type t

  val equal : t -> t -> bool
  val create : label -> vertex -> vertex -> t
  val label : t -> label
  val from : t -> vertex
  val too : t -> vertex
end

(* Podpunkt 2 *)
module Vertex : VERTEX with type label = int =
struct
  type label = int
  type t = label

  let equal (v1 : t) (v2 : t) = v1 = v2
  let create (lab : label) = lab
  let label (vert : t) = vert
end


module Edge : EDGE with type label = string and type vertex = Vertex.t =
struct
  type label = string
  type vertex = Vertex.t
  type t = label * vertex * vertex

  let equal e1 e2 = e1 = e2
  let create (lab : label) v1 v2 = (lab, v1, v2)
  let label ed = match ed with (l,_,_) -> l
  let from ed = match ed with (_,v,_) -> v
  let too ed = match ed with (_,_,v) -> v
end


(* Podpunkt 3 *)
module type GRAPH =
sig
  (* typ reprezentacji grafu *)
  type t

  module V : VERTEX
  type vertex = V.t

  module E : EDGE with type vertex = vertex

  type edge = E.t

  (* funkcje wyszukiwania *)
  val mem_v : t -> vertex -> bool
  val mem_e : t -> edge -> bool
  val mem_e_v : t -> vertex -> vertex -> bool
  val find_e : t -> vertex -> vertex -> edge
  val succ : t -> vertex -> vertex list
  val pred : t -> vertex -> vertex list
  val succ_e : t -> vertex -> edge list
  val pred_e : t -> vertex -> edge list


  (* funkcje modyfikcji *)
  val empty : t
  val add_e : t -> edge -> t
  val add_v : t -> vertex -> t
  val rem_e : t -> edge -> t
  val rem_v : t -> vertex -> t

  (* iteratory *)
  val fold_v : (vertex -> 'a -> 'a) -> t -> 'a -> 'a
  val fold_e : (edge -> 'a -> 'a) -> t -> 'a -> 'a


end

module Graph : GRAPH with module V = Vertex and module E = Edge =
struct
  (* typ reprezentacji grafu *)
  module V = Vertex
  type vertex = V.t

  module E = Edge
  type edge = E.t

  type t = vertex list * edge list

  (* funkcje pomocnicze *)
  let vertices = fst
  let edges = snd
  let areEdged v1 v2 = (fun e -> (V.equal v1 (E.from e)) && (V.equal v2 (E.too e)))
  let rec remove vOre compare xs = (*funkcja polimorficzna: dziala zarówno dla wierzchołków jak i krawędzi. vOre - wierzchołek/krawędź, compare- V.equal/E.equal, xs - lista wierzchołków/ lista krawędzi *)
    match xs with
    | [] -> []
    | x::xs' -> if compare vOre x
      then xs'
      else x :: remove vOre compare xs'

  (* funkcje wyszukiwania *)
  let mem_v graph v = List.mem v (vertices graph) (* Czy graf zawiera pewien wierzchołek v *)
  let mem_e graph e = List.mem e (edges graph) (* Czy graf zawiera pewną krawędź e *)
  let mem_e_v graph v1 v2 = List.exists (areEdged v1 v2) (edges graph)(* Czy graf zawiera krawędź z v1 do v2 *)
  let find_e graph v1 v2 = List.find (areEdged v1 v2) (edges graph) (* Znajduje krawędź z v1 do v2 *)
  let succ_e graph v = List.find_all (fun e -> V.equal v (E.from e)) (edges graph) (* Wszystkie krawędzie wychodzące z wierzchołka v *)
  let succ graph v = List.map E.too (succ_e graph v) (* Wszystkie wierzchołki do których prowadzi v *)
  let pred_e graph v = List.find_all (fun e -> V.equal v (E.too e)) (edges graph) (* Wszystkie krawędzie wchodzące do wierzchołka v *)
  let pred graph v = List.map E.from (pred_e graph v) (* Wszystkie wierzchołki które prowadzą do v *)

  (* funkcje modyfikacji *)
  let empty : t  = ([], []) (* Tworzenie pustego grafu : nie ma anie wierzchołków ani krawędzi *)
  let add_e graph e = (vertices graph, e :: (edges graph)) (* Chcielibyśmy aby nie dało się stworzyć krawędzi pomiędzy nieistniejącymi wierzchołkami (trzeba będzie dodać warunki) *)
  let add_v graph v = (v :: (vertices graph), edges graph)
  let rem_e graph e = (vertices graph, remove e E.equal (edges graph))
  let rem_v graph v = (remove v V.equal (vertices graph), edges graph)

  (* iteratory *)
  let fold_v f graph a = List.fold_right f (vertices graph) a
  let fold_e f graph a = List.fold_right f (edges graph) a


end


(* Podpunkt 4 *)

let g = ref Graph.empty
let v1 = Vertex.create(1)
let v2 = Vertex.create(2)
let e1 = Edge.create "1 -> 2" v1 v2
;;

g := Graph.add_v !g v1;
g := Graph.add_v !g v2;
g := Graph.add_e !g e1;

Graph.fold_v (fun v l -> (Vertex.label v) :: l) !g [];;
Graph.fold_e (fun e l -> (Edge.label e) :: l) !g [];;

Graph.mem_v !g v1;;
Graph.mem_e !g e1;;
Graph.mem_e_v !g v1 v2;;
Edge.label (Graph.find_e !g v1 v2);;

Vertex.label (List.hd (Graph.succ !g v1));;
Vertex.label (List.hd (Graph.pred !g v2));;
Edge.label (List.hd (Graph.succ_e !g v1));;
Edge.label (List.hd (Graph.pred_e !g v2));;

g := Graph.rem_e !g e1;
Graph.fold_e (fun e l -> (Edge.label e) :: l) !g [];;

g := Graph.rem_v !g v1;
Graph.fold_v (fun v l -> (Vertex.label v) :: l) !g [];;
g := Graph.rem_v !g v2;
Graph.fold_v (fun v l -> (Vertex.label v) :: l) !g [];;

(*
let g1 = Graph.add_v g v1
let g2 = Graph.add_v g1 v2
let g3 = Graph.add_e g2 e1
;;
Graph.fold_v (fun v l -> (Vertex.label v) :: l) g3 [];;
Graph.fold_e (fun e l -> (Edge.label e) :: l) g3 [];;

Graph.mem_v g3 v1;;
Graph.mem_e g3 e1;;
Graph.mem_e_v g3 v1 v2;;
Edge.label (Graph.find_e g3 v1 v2);;

Vertex.label (List.hd (Graph.succ g3 v1));;
Vertex.label (List.hd (Graph.pred g3 v2));;
Edge.label (List.hd (Graph.succ_e g3 v1));;
Edge.label (List.hd (Graph.pred_e g3 v2));;

let g4 = Graph.rem_e g3 e1;;
Graph.fold_e (fun e l -> (Edge.label e) :: l) g4 [];;

let g5 = Graph.rem_v g4 v1;;
Graph.fold_v (fun v l -> (Vertex.label v) :: l) g5 [];;
let g6 = Graph.rem_v g5 v2;;
Graph.fold_v (fun v l -> (Vertex.label v) :: l) g6 [];; *)























;;
