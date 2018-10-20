


let rec append xs ys =
  match xs with
  | [] -> ys
  | head::tail -> head :: (append tail ys);;
(* : 'a list list *)
let wstaw_na_kazda_pozycje (x : 'a) (xs : 'a list)  =
  let rec iter xs (poczatkowexs : 'a list) =
    match xs with
    (* za każdym razem będę odracać - nieparzyste i parzyste wywołania permutacji będą miały odrócone elementy podlist *)
    (* | [] -> (append poczatkowexs [x]) *)
    | [] -> [append poczatkowexs [x]]
    | head::tail ->
      let kolejny = (append poczatkowexs (x::xs)) and [dalej] = (iter tail (append poczatkowexs [head]))
      in [append kolejny dalej]
  in iter xs [];;

wstaw_na_kazda_pozycje 0 [1;2];;

(* let rec map f xs =
  match xs with
  | [] -> []
  | head::tail -> (f head) :: (map f tail);;

let rec perm xs =
  match xs with
    | [] -> [[]]
    | head::tail ->
      let permreszta = (perm xs)
      in map (wstaw_na_kazda_pozycje head) permreszta;; *)




      let rec append xs ys =
        match xs with
        | [] -> ys
        | head::tail -> head :: (append tail ys);;
      (* : 'a list list *)
      let wstaw_na_kazda_pozycje (x : 'a) (xs : 'a list)  =
        let rec iter xs (poczatkowexs : 'a list) =
          match xs with
          (* za każdym razem będę odracać - nieparzyste i parzyste wywołania permutacji będą miały odrócone elementy podlist *)
          (* | [] -> (append poczatkowexs [x]) *)
          | [] -> [append poczatkowexs [x]]
          | head::tail ->
            let kolejny = (append poczatkowexs (x::xs)) and [dalej] = (iter tail (append poczatkowexs [head]))
            in [kolejny;dalej]
        in iter xs [];;

      wstaw_na_kazda_pozycje 0 [1;2];;

      let w = wstaw_na_kazda_pozycje;;
      w 0 [];;
      w 1 [0];;
      w 2 [1;0];;
      w 2 [0;1];;
      (* let rec map f xs =
        match xs with
        | [] -> []
        | head::tail -> (f head) :: (map f tail);;

      let rec perm xs =
        match xs with
          | [] -> [[]]
          | head::tail ->
            let permreszta = (perm xs)
            in map (wstaw_na_kazda_pozycje head) permreszta;; *)
