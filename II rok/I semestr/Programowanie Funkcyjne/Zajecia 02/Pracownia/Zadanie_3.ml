let rec merge (rel : 'a -> 'a -> bool) (xs : 'a list) (ys : 'a list) =
  match (xs,ys) with
  | ([],[]) -> []
  | ([],_) -> ys
  | (_,[]) -> xs
  | (hx::tx, hy::ty) when (rel hx hy) -> (hx :: (merge rel tx ys))
  | (hx::tx, hy::ty) when (rel hy hx) -> (hy :: (merge rel xs ty));;
merge (<=) [1;2;3] [1;2;4];;

let rec reverse_iter xs result =
  match xs with
  | [] -> result
  | h :: t -> reverse_iter t (h :: result);;

let rec meerge (rel : 'a -> 'a -> bool) (xs : 'a list) (ys : 'a list) (result : 'a list) =
match (xs,ys) with
| ([],[]) -> (reverse_iter result [])
| ([],_) -> reverse_iter result ys
| (_,[]) -> reverse_iter result xs
| (hx::tx, hy::ty) when (rel hx hy) -> (meerge rel tx ys (hx::result))
| (hx::tx, hy::ty) when (rel hy hx) -> (meerge rel xs ty (hy::result));;

meerge (<=) [0;2;4;6] [-1;1;1;1;3] [];;

let rec halve xs result =
  match (xs, result) with
  | ([],_) -> result
  | (h1::h2::t, (left,right)) -> halve t (h1::left, h2::right)
  | (h1::[], (left,right)) -> (h1::left, right);;
  (* | (head::tail, (left, right)) ->
      if bol
        then (halve tail (head::left, right) false)
        else (halve tail (left, head::right) true);; *)
let rec mergesort (xs : 'a list) (rel : 'a -> 'a -> bool) : 'a list =
  match xs with
    | [] -> []
    | [x] -> [x]
    | _  ->
    let (left, right) = (halve xs ([],[]))
    in meerge rel (mergesort left rel) (mergesort right rel) [];;

mergesort [1; -1] (<=);;

halve [1;2;3;4;5] ([],[]);;
mergesort [0;9;8;7;6;5;4;3;2;1] (<=);;


let rec append xs ys =
  match xs with
  | [] -> ys
  | head::tail -> head :: (append tail ys);;


let rec reverse_ xs result =
  match xs with
    | [] -> result
    | h :: t -> reverse_ t (h :: result);;
let rec merge4 (xs : 'a list) (ys : 'a list) (rel : 'a -> 'a -> bool) (result : 'a list) =
  match (xs, ys) with
    | ([], []) -> result
    | ([],_) -> (reverse_ ys result)
    | (_,[]) -> (reverse_ xs result)
    | (hx::tx, hy::ty) ->
      if (rel hx hy)
        then merge4 tx ys rel (hx::result)
        else merge4 xs ty rel (hy::result);;

(* merge [1;3;5] [2;4;6] (<=) [];; *)
let notrel rel = (fun x y -> not (rel x y));;
let rec mergesort_ xs rel =
  match xs with
    | [] -> []
    | x::[] -> xs
    | _  ->
      let (left, right) = (halve xs ([],[]))
      in merge4 (mergesort_ left (notrel rel)) (mergesort_ right (notrel rel)) rel [];;


let mergesort4 (xs : 'a list) (rel : 'a -> 'a -> bool) : 'a list =
    (* (function x y -> not (rel x y)) *)
    mergesort_ xs (notrel rel);;
