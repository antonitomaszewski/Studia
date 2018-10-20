let ctrue  (b1 : 'a) (b2 : 'a) : 'a = b1;;
let cfalse (b1 : 'a) (b2 : 'a) : 'a = b2;;

let cand p q = (p q) cfalse;;
let cor p q = (p ctrue) q;;

let c2b c = c true false;;
let b2c b = if b then ctrue else cfalse;;

c2b (b2c true);;
c2b (b2c false);;

c2b (cand ctrue cfalse);;
c2b (cor ctrue cfalse);;
