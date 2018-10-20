let rec halve2 lista result boo =
  match lista with
  [] -> result
  | head::tail ->
  	match result with
  		(left, right) ->
  			if boo
  				then (halve2 tail (head::left, right) false
  )
  				else (halve2 tail (left, head::right) true);;


let halve lista =
  let rec iter lista wynik boo =
    match (lista, wynik) with
      | ([],_) -> wynik
      | (head::tail, [left; right]) ->
          if boo
            then (iter tail ([left; head::right]) false)
            else (iter tail ([head::left; right]) true)
  in (iter lista [[];[]] false);;

halve [1;2;3];;
