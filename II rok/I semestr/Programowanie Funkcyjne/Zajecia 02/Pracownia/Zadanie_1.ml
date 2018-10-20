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
