#directory "/home/nudge/Pulpit/Programowanie Funkcyjne";;

let rec append xs ys =
  match xs with
  | [] -> ys
  | head::tail -> head :: (append tail ys);;

let rec map f xs =
  match xs with
  | [] -> []
  | head::tail -> (f head)::(map f tail);;

let rec map_append f xs =
  match xs with
  | [] -> []
  | head::tail -> (append (f head) (map_append f tail));;

let rec _reverse xs result =
  match xs with
    | [] -> result
    | h :: t -> _reverse t (h :: result)

let reverse xs = _reverse xs [];;

let rec length (xs : 'a list) : int =
  match xs with
    | [] -> 0
    | _::tail -> 1 + (length tail);;
