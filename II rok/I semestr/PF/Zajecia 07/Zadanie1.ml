let rec fix (f : ('a -> 'b) -> 'a -> 'b) (x : 'a) = f (fix f) x

let fac = fix (fun f -> fun n -> if n=0 then 1 else n * (f (n-1)))

let fix (f : ('a -> 'b) -> 'a -> 'b) =
  let r = ref (fun x -> x)
  in let fix_ f' n = f !r n
  in r := fix_ f;
  !r
let fact =
  fix (fun f -> fun n -> if n = 0 then 1 else n * (f (n - 1)))
;;
(* fact 0;; *)
print_string "z refami\n";
for i = 0 to 10 do
  print_int i;
  print_string " -> ";
  print_int (fact i);
  print_newline ()
done
;;
print_string "z let rec\n";
for i = 0 to 10 do
  print_int i;
  print_string " -> ";
  print_int (fac i);
  print_newline ()
done
;;

type 'a fix = Fix of ('a fix -> 'a)
(* let y = fun f -> ((fun x a  : 'a fix -> f (x (Fix x)) a) (fun x a -> f (x x) a)) *)

let y t =
  let p (Fix f) x = t (f (Fix f)) x
  in p (Fix p)

let fact n =
  let t_fact f x =
    if x=0
    then 1
    else x * (y f (x-1))
  in t_fact (fun x -> x) n

;;
fact 4;;

;;
