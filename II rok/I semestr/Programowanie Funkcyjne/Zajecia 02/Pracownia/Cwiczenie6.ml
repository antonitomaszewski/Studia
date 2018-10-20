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
