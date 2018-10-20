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
