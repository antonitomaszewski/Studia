-- To jest skrypt Haskella. Mozna go wykonac w srodowisku interakcyjnym za pomoca komendy 
-- :script <filename>
-- Praca interakcyjna w cyklu REPL

-- Przeglad podstawowych konstrukcji jezyka

1+2*3
:type it
2.5 + 3.5
:t it
-- if you turn on the +t option, GHCi will show the type of each variable bound by a statement.
:set +t
2 + 3.5
not (1 > 2) 
'a'
let x = 3+2
    
let s1 = "To "      
let s2 = "ciekawe" 
let l1 = s1 : s2 : []  
:show bindings
-- show jest zwykla funkcja, zwracajaca wartoœæ typu String,
-- pod warunkiem, ¿e typ argumentu nale¿y do klasy Show
:t show
show x
let p = (x+1, s1++s2)
show p    
snd p
let p = -3.14
    
let b = 5    
(let x=b*b in x+x)+1     

let double = \x -> 2*x
double 6    
(\x -> 2*x) 6
let twice x = 2*x
twice (2+3)    
twice 2+3

let silnia n = if n==0 then 1 else n*silnia(n-1)
silnia 4    
let id x = x
id 5
id (3+4, "siedem")  
id id "OK"

[]
let l1 = 1:2:3:[]
let l2 = [1, 2, 3] 
l1 == l2
[1,2]++[2,3]
head [1,2,3]
tail [1,2,3]    
reverse [1,2,3]
length [5,6,7]
[[]]  

(8, "osiem")  -- nawiasy sa konieczne
(1,1.0,"jeden")
(1,(1.0,"jeden"))
fst (8, "osiem")
:t snd
(if 2==3 then 4 else 5) + 5

(\x -> x*x) 5
let f = \y -> \x -> x*x+y
f 2 5
let fdwa = f 2
fdwa 5
let f5 = \z -> f z 5
f5 2

let plus = \x -> \y -> x+y
let plus' x = \y -> x+y    
let plus'' x y = x+y    
let plus3 = \x y -> x+y    
    
:t \(x,y) -> x+y
(\(x,y) -> x+y) (4,5)
let plus (x,y) = x+y 
plus (4,5)
let add x y = x+y    
add 4 5

let nonsens n = if n==0 then 1 else n*nonsens(n+1)
-- nonsens 4
-- Exception: stack overflow

let silnia n = if n==0 then 1 else n*silnia(n-1)
-- silnia (-4) 
-- Exception: stack overflow

let silnia n = if n==0 then 1 else if n>0 then n*silnia(n-1) else error "ujemny argument"
-- silnia (-4) 
-- *** Exception: ujemny argument 

:t (+)
let succ = (+) 1
succ 3
let  (++)  c1 c2 = ((fst c1) + (fst c2), (snd c1) + (snd c2))
let c = (2,3) in c ++ c

mod 12 5
-- z ka¿dej dwuargumentowej funkcji w postaci rozwiniêtej mo¿na utworzyæ operator infiksowy,
-- zapisujac jej identyfikator miêdzy para lewych (odwróconych) apostrofów(ang. backquote, backtick)
12 `mod` 5



    
