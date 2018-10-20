
let rec reverse_ xs result =
    match xs with
      | [] -> result
      | h :: t -> reverse_ t (h :: result);;


let rec halve xs result =
  match (xs, result) with
  | ([],_) -> result
  | (h1::h2::t, (left,right)) -> halve t (h1::left, h2::right)
  | (h1::[], (left,right)) -> (h1::left, right);;

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

(* mergesort [] (<=);;
mergesort [1] (<=);;
mergesort [1;2] (<=);;

halve [1;2] ([],[]);;

halve [1;2;3] ([],[]);;

mergesort [3;1] (<=);;

mergesort [3;2;1] (<=);;

mergesort [4;2;3;1] (<=);;

mergesort [4;3] (notrel (<=));;
mergesort [2;1] (notrel (<=));;

merge [3;4] [1;2] (<=);; *)


mergesort4 [9;4;5;6;3;2;1;7] (<=);;
mergesort4 [5;7;8;6;4;3;2;0;9] (<=);;
mergesort4 [1;0;1;0;9;0;9;0;9;0;9;0;9;0;9;0;9;0] (<=);;
