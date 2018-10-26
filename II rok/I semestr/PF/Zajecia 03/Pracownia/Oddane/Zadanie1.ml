(* #directory "/home/nudge/Pulpit/" *)
#use "funkcje.ml";;
let horner (x : float) (xs : float list) =
  let rec _horner acc = function
    | [] -> acc
    | hd::tl -> _horner (acc *. x +. hd) tl
  in _horner 0. xs;;
horner 1. [];;
horner 2. [1.; 0.; -1.; 2.];;

let horner2 (x : float) (xs : float list) =
  List.fold_left (fun acc ai -> acc*.x+.ai) 0. xs;;
horner2 2. [1.; 0.; -1.; 2.];;
