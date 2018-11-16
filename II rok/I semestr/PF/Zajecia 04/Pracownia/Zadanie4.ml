type logic = True | False;;
type formula = Var | Altj of formula * formula | Conj of formula * formula | Neg of formula;;

let taut form = 
