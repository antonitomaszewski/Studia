let sigma f m =
  let rec suma (i,s) =
    if i=m then s else suma(i+1, s +. f(i+1))
  in suma (0, f 0);;

sigma (function k -> float(k*k)) 9;;
sigma (function i -> sigma (function j -> float(i+j)) 4) 3;;


let sigma2 g m n =
  sigma (function i -> sigma (function j -> g(i,j)) n) m;;

sigma2 (function (k,l) -> float(k+l)) 3 4;;


let curry f x y = f (x,y);;
let uncurry f (x,y) = f x y;;

let plus (x,y) = x+y;;
curry plus 4 5;;
let add x y = x+y;;
uncurry add (4,5);;

let ($.) f g = function x -> f (g x);;
let sqr x = x*x;;
(sqr $. sqr) 2;;

let third l3 = (List.hd $. List.tl $. List.tl) l3;;
third [1;2;3;4;5];;

let next_char = Char.chr $. (+) 1 $. Char.code;;
next_char 'c';;

abs 1 -5;;
abs @@ 1 -5;;

let (@@) f x = f x;;
abs 1 -5;;
abs @@ 1 -5;;
let (|>) x f = f x;;
5-12 |> abs |> succ;;


let rec map f xs =
  match xs with
    [] -> []
  | x::xs -> (f x) :: map f xs;;
map (fun x -> x*x) [1;2;3;4];;
List.map;;
List.map String.length ["Litwo"; "Ojczyzno";"moja"];;

(* function
  p1 -> w1
  ...
  <=>
function zmienna ->
  match zmienna with
    p1 -> w1
    ... *)
let rec filter pred = function
    [] -> []
  | x::xs -> if pred x
                then x::filter pred xs
                else filter pred xs;;
List.filter (fun s -> String.length s <= 5) ["Litwo"; "ojczyzno"; "moja"];;

let filter_bad p =
  let rec find acc = function
      [] -> acc
    | x::xs -> if p x then find(acc@[x]) xs else find acc xs
  in find [];;

let filter p =
  let rec find acc = function
      [] -> List.rev acc
    | x::xs -> if p x then find (x::acc) xs else find acc xs
  in find [];;


let primes to_n =
  let rec sieve n =
    if n <= to_n
      then n::sieve(n+1)
      else []
  and find_primes = function
        h::t -> h::find_primes (List.filter (fun x -> x mod h <> 0) t)
      | [] -> []
  in find_primes (sieve 2);;

primes 30;;


let rec insert poprzedza elem xs =
  match xs with
      [] -> [elem]
    | h::t as l ->
        if poprzedza elem h
          then elem::l
          else h::(insert poprzedza elem t);;

let insert_le elem = insert (<=) elem;;
insert_le  4 [1;2;3;4;5;6;7;8;9;9];;

let rec sumlist xs =
  match xs with
      h::t -> h + sumlist t
    | [] -> 0;;

let rec foldr f xs acc =
  match xs with
    | h::t -> f h (foldr f t acc)
    | [] -> acc;;

let sumlist xs = foldr (+) xs 0;;

let rec foldl f acc = function
  |  h::t -> foldl f (f acc h) t
  | [] -> acc;;

let sumlist = List.fold_left (+) 0;;
sumlist[4;3;2;1];;

let prodlist = List.fold_left ( * ) 1;;
prodlist [4;3;2;1];;

let flatten xs = List.fold_left (@) [] xs;;
flatten [[5;6];[1;2;3]];;

let implode = List.fold_left (^) "";;
implode ["Ala ";"ma ";"kota"];;

let silnia' n =
  let rec f(i,s) = if i<n then f(i+1, (i+1)*s) else (i,s)
  in snd (f(0,1));;
silnia' 5;;

let f z y x = y (y z x);;
