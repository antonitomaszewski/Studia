(* let rec quicksort = function
  | [] -> []
  | [x] -> [x]
  | x::xs -> let (small, large) = partition x xs *)

  let rec quicksort = function
  [] -> []
  | [x] -> [x]
  | xs -> let small = List.filter (fun y -> y < List.hd xs ) (List.tl xs)
  and large = List.filter (fun y -> y >= List.hd xs ) (List.tl xs)
  in quicksort small @ (List.hd xs)::quicksort large;;
  (* zapętlała się dla listy w której najmniejszy element był na początku, zawsze small==[] i large==xs *)

quicksort [1;2;3;4];;


let rec quicksort' = function
  | [] -> []
  | x::xs -> let small = List.filter (fun y -> y < x) xs
              and large = List.filter (fun y -> y > x) xs
            in quicksort' small @ (x :: quicksort' large);;
(* jeśli dany element filtrujący występuje w liście częściej niż raz pozostanie tylko jedna jego kopia *)
quicksort' [1;23;4;5];;
quicksort' [1;2;1;1;1];;


let rec podzial x acc rel = function
  | [] -> acc
  | hd::tl -> let (left, right) = acc
              in let (newleft, newright) = if (rel hd x) then (hd::left, right) else (left, hd::right)
              in podzial x (newleft, newright) rel tl;;
podzial 1 ([],[]) (<=) [-1;4;7;0;-2];;

let rec quicksort'' rel = function
  | [] -> []
  | [x] -> [x]
  | x::xs -> let (small,large) = podzial x ([],[]) rel xs
              in (quicksort'' rel small) @ (x::(quicksort'' rel large));;

quicksort'' (<=) [1;1;1;1];;
quicksort'' (<=) [5;4;3;2;1];;
quicksort'' (<=) [1;2;3;4;5];;
quicksort'' (<=) [4;2;5;1;3];;
