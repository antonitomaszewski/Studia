let (fresh, reset) =
  let r = ref 0
  in let fre =
       fun (x : string) -> r := !r + 1;
         x ^ (string_of_int !r)
  in let res i = r := i
  in fre, res
;;
fresh "x"
;;
fresh "x"
;;
reset 7
;;
fresh "x"

;;
fresh "a"
;;
