let polyn (x : float) (xs : float list) =
  let rec _polyn x' = function
    | [] -> 0.
    | hd::tl -> hd*.x' +. (_polyn (x' *. x) tl)
  in _polyn 1. xs;;

polyn 1. [];;
polyn 2. [2.; -1.; 0.; 1.];;
polyn 2. [1.; 0.; -1.; 2.];;

let polyn2 (x : float) (xs : float list) =
  List.fold_right (fun ai acc -> acc*.x +. ai) xs 0.;;

polyn2 1. [];;
polyn2 2. [2.; -1.; 0.; 1.];;
polyn2 2. [1.; 0.; -1.; 2.];;
