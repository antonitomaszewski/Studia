let rec insert a rel = function
  | [] -> [a]
  | (x::xs) -> if rel a x then a::x::xs else x::(insert a rel xs)
  ;;
insert 1 (<=) [-1;0;3;5;6];;

let rec insertsort rel = function
  | [] -> []
  | hd::tl -> insert hd rel (insertsort rel tl)
  ;;

insertsort (<=) [5;7;3;2;8;9;0;1];;

(* merge już był na liscie 2 Zadanie 3 *)
