let rec reverse_iter xs result =
  match xs with
  | [] -> result
  | h :: t -> reverse_iter t (h :: result);;

let partition (pred : 'a -> bool) (xs : 'a list) : ('a list * 'a list =
  let rec iter xs (result : 'a list * 'a list) =
    match xs with
      | [] -> let (left, right) = result
              in ((reverse_iter left []),(reverse_iter right []))
      | head::tail ->
          match result with
            (left, right) ->
              match (pred head) with
                | true -> (iter tail (head::left, right))
                | false -> (iter tail (left, head::right))
  in iter xs ([], []);;



  (partition (function x -> (x <= 5)) [6;1;0;9;2;3;6;4;5]);;
