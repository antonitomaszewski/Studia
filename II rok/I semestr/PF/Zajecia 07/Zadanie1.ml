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
