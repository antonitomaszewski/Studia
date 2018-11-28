let x = ref 5;;
!x;;
x := 7;;
!x;;

let x = ref 0;;
let y = x;;
y := 10;;
!x;;


let x = ref 0;;
let y = ref 0;;
x == y;;
x = y;;
[1;2;3] == [1;2;3];;
[1;2;3] = [1;2;3];;
1==1;;
let x = ref [];;
x := 1 :: !x;;
x;;
x := true :: !x;;

let f a b = a;;
let g = f 1;;
g "ala";;
let g1 x = f 1 x;;


type punkt = {wx:float; mutable wy:float};;
let p = {wx=1.; wy=0.};;

p.wy <- 3.;;
p;;

let v = [| 2.58; 3.14; 8.73 |];;

let v = Array.make 3 3.14;;

v.(1) +. 1.;;


let v = Array.make 3 0;;
let m = Array.make 3 v;;
m.(0).(0) <- 1;;
m;
