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


(* let cycle xs n =
  let rec iter koncowkaxs poczatekxs_odwrocony n =
    if (n=0)
      then append koncowkaxs (reverse poczatekxs_odwrocony)
      else
      (* match koncowkaxs with
        hd::new_koniec -> (iter new_koniec (hd::poczatekxs_odwrocony) (n-1)) *)
      let hd::new_koniec = koncowkaxs
      in  (iter new_koniec (hd::poczatekxs_odwrocony) (n-1))
  in iter xs [] n;;


  cycle [1;2;3;4;5] 3;; *)



  let rec cycle (xs : 'a list) (n : int) : 'a list =
    if n=0 then xs
    else match xs with
      | tail::head -> append (cycle head (n-1)) [tail]
      | [] -> [];;

  cycle [1;2;3;4;5] 3;;
