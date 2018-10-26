let rec swap ai xs =
  match xs with
  | [] -> (false,[],ai)
  | h::t when ai >= h -> (false, h::t, ai)
  | h::t when ai < h ->
    let (b, ys, ak) = swap ai t
    in if not b
    then (true, ai::ys, h)
    else (b, h::ys, ak)
  | _ -> (false,[],ai);;


let rec find1 xs index =
  match xs with
  | [] -> -1
  | [x] -> -1
  | h1::h2::t when h1 >= h2 -> find1 (h2::t) (index+1)
  | h1::h2::t when h1 < h2 -> max index (find1 (h2::t) (index+1))
  | _ -> -1;;



let rec _nextperm xs =
  match xs with
  | [] -> (false, [])
  | [x] -> (false, [x])
  | h1::h2::t when h1 >= h2 ->
    let (b, ys) = (_nextperm (h2::t))
    in (b, h1::ys)
  | h1::h2::t when h1 < h2 ->
    let (b, ys) = _nextperm (h2::t)
    in if not b
    then let (b, ys, ak) = swap h1 (h2::t)
      in (true, ak::(List.rev ys))
    else (b, h1::ys)
  | _::_ -> (false, []);;

let nextperm xs =
  let (b, np) = _nextperm xs
  in if np = xs
  then List.rev xs
  else np;;
nextperm [1;2;3];;
nextperm [4;3;2;1];;

nextperm [1;5;7;9;8;0];;
nextperm [3;4;2;1];;
nextperm ['b';'c';'a'];;
nextperm [];;
nextperm ['a'];;
nextperm ['a';'b'];;

let permutations xs =
  let rec _permutations ys =
    if ys=xs
    then []
    else ys::(_permutations (nextperm ys))
  in xs ::(_permutations (nextperm xs));;
permutations [1;2;3];;
permutations[];;
permutations[1];;
