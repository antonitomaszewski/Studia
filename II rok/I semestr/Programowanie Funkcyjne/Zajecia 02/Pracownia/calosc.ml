(* Zadanie 1 *)

let rec append xs ys =
  match xs with
  | [] -> ys
  | head::tail -> head :: (append tail ys);;

let rec map_append f xs =
  match xs with
  | [] -> []
  | head::tail -> (append (f head) (map_append f tail));;

let rec sublists xs =
  match xs with
    | [] -> [[]]
    | head::tail ->
      map_append (function sublist -> [sublist; head::sublist]) (sublists tail);;

sublists [];;
sublists [1];;
sublists [1;2];;
sublists [1;2;3];;


(* Zadanie 2 *)

let reverse xs =
  let rec reverse_iter xs result =
    match xs with
      | [] -> result
      | h :: t -> reverse_iter t (h :: result)
  in reverse_iter xs [];;

let rec append xs ys =
  match xs with
    | [] -> ys
    | head::tail -> head :: (append tail ys);;

let rec length (xs : 'a list) : int =
  match xs with
    | [] -> 0
    | _::tail -> 1 + (length tail);;



let cycle2 xs n =
  let rec iter koncowkaxs poczatekxs_odwrocony n =
    match (koncowkaxs, n) with
      | (_,0) -> append koncowkaxs (reverse poczatekxs_odwrocony)
      | (head::tail,_) -> iter tail (head::poczatekxs_odwrocony) (n-1)
  in iter xs [] (n mod (length xs));;


cycle2 [1;2;3;4;5] 3;;

(* Zadanie 3 *)

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


(* Zadanie 4 *)

let rec append xs ys =
  match xs with
  | [] -> ys
  | head::tail -> head :: (append tail ys);;

let rec reverse_iter xs result =
  match xs with
  | [] -> result
  | h :: t -> reverse_iter t (h :: result);;

let partition (pred : 'a -> bool) (xs : 'a list) : ('a list * 'a list) =
  let rec iter  xs (result : 'a list * 'a list) =
    match (xs, result) with
      | ([],(left, right)) -> ((reverse_iter left []),(reverse_iter right []))
      | (head::tail, (left, right)) when (pred head) -> (iter tail (head::left, right))
      | (head::tail, (left, right)) when (not (pred head)) -> (iter tail (left, head::right))
  in iter xs ([],[]);;

(partition (function x -> (x <= 5)) [6;1;0;9;2;3;6;4;5]);;
let rec quicksort (rel : 'a -> 'a -> bool) (xs : 'a list) =
  match xs with
    | [] -> []
    | head::[] -> xs
    | head::tail ->
      let (mniejsze, wieksze) = (partition (function x -> rel x head) tail)
      in (append (quicksort rel mniejsze) (head::(quicksort rel wieksze)));;


quicksort (<=) [5;-1;6;7;3;4;9;8;0;2];;

(* Zadanie 5 *)

let rec append xs ys =
  match xs with
  | [] -> ys
  | head::tail -> head :: (append tail ys);;
(* : 'a list list *)
let wstaw_na_kazda_pozycje (x : 'a) (xs : 'a list)  =
  let rec iter xs (poczatkowexs : 'a list) =
    match xs with
    (* za każdym razem będę odracać - nieparzyste i parzyste wywołania permutacji będą miały odrócone elementy podlist
    | [] -> (append poczatkowexs [x]) *)
    | [] -> [append poczatkowexs [x]]
    | head::tail ->
      let kolejny = (append poczatkowexs (x::xs)) and dalej = (iter tail (append poczatkowexs [head]))
      in append [kolejny] dalej
  in iter xs [];;

wstaw_na_kazda_pozycje 0 [1;2];;

let rec map_append f xs =
  match xs with
  | [] -> []
  | head::tail -> (append (f head) (map_append f tail));;

map_append (wstaw_na_kazda_pozycje 0) [[]];;
map_append (wstaw_na_kazda_pozycje 0) [[1]];;
map_append (wstaw_na_kazda_pozycje 0) [[1;2];[2;1]];;

let rec perm xs =
  match xs with
    | [] -> [[]]
    | head::tail ->
      let permreszta = (perm tail)
      in let dalej = map_append (wstaw_na_kazda_pozycje head) permreszta
        in dalej;;

perm [];;
perm [0];;
perm [0;1];;
perm [0;1;2];;
perm [0;1;2;3];;


(* Zadanie 6 *)


let rec suffixes xs =
  match xs with
    | [] -> [[]]
    | hd::tl -> xs :: (suffixes tl);;

suffixes [1;2;3];;

let rec map f xs =
  match xs with
  | [] -> []
  | head::tail -> (f head) :: (map f tail);;

let rec preffixes xs =
  match xs with
    | [] -> [[]]
    | hd::tl ->
        let next_prefs = preffixes tl
        in [] :: (map (function ys -> hd::ys) next_prefs);;

preffixes [1;2;3];;
