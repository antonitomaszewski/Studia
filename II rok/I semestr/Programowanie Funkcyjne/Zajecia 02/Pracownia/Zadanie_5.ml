let rec append xs ys =
  match xs with
  | [] -> ys
  | head::tail -> head :: (append tail ys);;
(* : 'a list list *)
let wstaw_na_kazda_pozycje (x : 'a) (xs : 'a list)  =
  let rec iter xs (poczatkowexs : 'a list) =
    match xs with
    (* za każdym razem będę odracać - nieparzyste i parzyste wywołania permutacji będą miały odrócone elementy podlist
    | [] -> (append poczatkowexs [x]) *)
    | [] -> [append poczatkowexs [x]]
    | head::tail ->
      let kolejny = (append poczatkowexs (x::xs)) and dalej = (iter tail (append poczatkowexs [head]))
      in append [kolejny] dalej
  in iter xs [];;

wstaw_na_kazda_pozycje 0 [1;2];;

let rec map_append f xs =
  match xs with
  | [] -> []
  | head::tail -> (append (f head) (map_append f tail));;

map_append (wstaw_na_kazda_pozycje 0) [[]];;
map_append (wstaw_na_kazda_pozycje 0) [[1]];;
map_append (wstaw_na_kazda_pozycje 0) [[1;2];[2;1]];;

let rec perm xs =
  match xs with
    | [] -> [[]]
    | head::tail ->
      let permreszta = (perm tail)
      in let dalej = map_append (wstaw_na_kazda_pozycje head) permreszta
        in dalej;;

perm [];;
perm [0];;
perm [0;1];;
perm [0;1;2];;
perm [0;1;2;3];;
