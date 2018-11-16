type complex = {re : float; im : float};;
let c = {re = 2.; im = 3.};;
c = {im = 3.; re = 2.};;
(* let d = {im = 4.};; *)
let add_complex c1 c2 = {re = c1.re +. c2.re; im = c1.im +. c2.im};;
add_complex c c;;

let mult_complex {re = x1; im = y1} {re = x2; im = y2} =
  {re = x1*.x2 -. y1*.y2; im = x1*.y2 +. x2*.y1};;
mult_complex c c;;
(* strona 23 *)
