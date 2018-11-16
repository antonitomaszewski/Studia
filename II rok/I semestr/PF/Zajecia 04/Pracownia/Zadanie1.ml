let ispalindrome xd =
  let rec ispalindrome_ xd yd =
    match (xd, yd) with
    | (_, []) -> (true, xd)
    | (h::t, [x]) -> (true, t)
    | (hx::tx, hy1::hy2::ty) ->
      let (b, h::rest) = (ispalindrome_ tx ty)
      in (b && (hx = h), rest)
    | (_,_) -> (true, [])
  in fst (ispalindrome_ xd xd);;
ispalindrome [];;
ispalindrome [1];;
ispalindrome [1;2;2];;
ispalindrome [1;1];;
ispalindrome [1;2;3;3;2;1];;
ispalindrome [1;2;2;3];;
ispalindrome [1;2;3;4;3;2;1];;
