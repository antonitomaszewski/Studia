function (x,y) -> x+y;;
function (x,y,z) -> if x then y else z;;
function (x, (y,z)) -> ((x,y),z);;

let cons = fun x xs -> x :: xs;;
let car = function xs -> List.hd xs;;
let cdr = function xs -> List.tl xs;;
let null = [];;
let czy_null = function xs -> xs = null;;
let rec append = fun xs ys -> if xs=null then ys else (cons (car xs) (append (cdr xs) ys));;



let rec flatten = function xss ->
        if (czy_null xss)
          then null
          else (append (car xss) (flatten (cdr xss)));;

let rec count (x, xs) = if (czy_null xs) then 0 else if ((car xs) = x) then (1 + count (x, (cdr xs))) else (count (x, (cdr xs)));;

let rec duplicate (x, n) = if (n = 0) then null else (cons x (duplicate (x, n-1)));;

let rec map = fun f xs -> if (czy_null xs) then null else (cons (f (car xs)) (map f (cdr xs)));;

let sqr = function n -> n*n;;
let sqr_list = function xs -> map sqr xs;;

let rec reverse_iter = fun xs result -> if (czy_null xs) then result else (reverse_iter (cdr xs) (cons (car xs) result));;
let reverse xs = reverse_iter xs null;;

reverse [1;2;3;4];;

let palindrome xs = xs = reverse xs;;
