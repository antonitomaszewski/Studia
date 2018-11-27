(** Typ danych reprezentujący formuły zdaniowe *)
type 'a prop = Var of 'a | Top | Bot
             | Conj of 'a prop * 'a prop
             | Disj of 'a prop * 'a prop
             | Impl of 'a prop * 'a prop

(** Typ danych reprezentujący drzewa dowodu w systemie dedukcji
    naturalnej, wraz z typem ramek *)
type 'a pt = Ax of 'a prop
           | TopI
           | ConjI  of 'a pt * 'a pt
           | DisjIL of 'a pt * 'a prop
           | DisjIR of 'a prop * 'a pt
           | ImplI  of 'a hypt
           | BotE   of 'a prop
           | ConjEL of 'a pt
           | ConjER of 'a pt
           | DisjE  of 'a pt * 'a hypt * 'a hypt
           | ImplE  of 'a pt * 'a pt
and 'a hypt = 'a prop * 'a pt


(** Typ danych reprezentujący skryptowy zapis dowodu (patrz lista 5) w
    systemie dedukcji naturalnej, wraz z typem ramek *)
type 'a ps = PDone of 'a prop
           | PConc of 'a prop * 'a ps
           | PHyp  of 'a shyp * 'a ps
and 'a shyp = 'a prop * 'a ps


type 'a thing = TGoal of string * ('a prop) * ('a pt)
              | SGoal of string * ('a prop) * ('a ps)

(** Plik zawiera listę dowodów (jednego lub drugiego rodzaju) ze
    zmiennymi typu string *)
type file = string thing list


type result = Error of string | Result of string prop















(*
(* let andel (Conj(p, q) : 'a prop) = (true, p)
   let ander (Conj(p, q) : 'a prop) = (true, q)
   let impe (p1 : 'a prop) (Ax(Impl(p2,q)) : 'a pt) = if (p1=p2) then (true, q) else (false, q)
   let ore (Disj(p1,q1) : 'a prop) (ImplI(p2, d1) : 'a pt) (ImplI(q2, d2) : 'a pt) =
   if ((p1 <> p2) || (q1 <> q2))
   then (false, p1)
   else let (b1, r1) = impli(p2,d1) and (b2, r2) = impli(q2, d2)
    in if (b1 && b2 && r1=r2)
    then (true, r1)
    else (false, r1) *)

(* let rec isFormIn f formList =
   match formList with
   | [] -> false
   | f2::fs -> if (f=f2) then true else isFormIn f fs *)

(* let rec checkValidityProof (assump : string prop list) (proof : string pt) : (bool * string pt)=
   match proof with
   | Ax(f) -> ((List.mem f assump), Ax(f))
   | TopI -> (true, TopI)
   | ConjI(p,q) -> let (bl, left) = (checkValidityProof assump p) and (br, right) = (checkValidityProof assump q)
    in ((bl && br), Ax(Conj(left, right))
       | DisjIL(p,_) -> checkValidityProof assump p
       | DisjIR(_,q) -> checkValidityProof assump q
       | ImplI(p,q) -> checkValidityProof (p::assump) q
       | BotE(_) -> true
       | ConjEL(p) -> *)
let rec checkValidityProof (assump : string prop list) (proof : string pt) : (bool * string prop)=
  match proof with
  | Ax(f) -> ((List.mem f assump), f)
  | TopI -> (true, Top)
  | ConjI(p,q) -> let (bl, left) = (checkValidityProof assump p) and (br, right) = (checkValidityProof assump q)
    in if ((not bl) || (not br))
    then if (br) then (false, left) else (false, right)
    else ((bl && br), (Conj(left, right)))
  | DisjIL(p,q) -> let (bl, left) = checkValidityProof assump p
    in if bl
    then (bl, Conj(left, q))
    else (false, left)
  | DisjIR(p,q) -> let (br, right) = checkValidityProof assump q
    in if br
    then (br, Conj(p, right))
    else (false, right)
  | ImplI(p,q) -> checkValidityProof (p::assump) q
  | BotE(_) -> (true, Bot)
  | ConjEL(Ax(Conj(p,q))) -> let (b, left) = checkValidityProof assump (Ax p)
    in if b
    then (true, p)
    else (false, p)
  (* | ConjEL(con) -> match con with
     | Ax(Conj(p,q)) -> let (b, left) = checkValidityProof assump (Ax p)
      in if b
      then (true, left)
      else (false, left)
     (* w conju nie był conj !!! *)
     | _ -> (false, con) *)
  | ConjER(Ax(Conj(p,q))) -> let (b, right) = checkValidityProof assump (Ax q)
    in if b
    then (true, q)
    else (false, q)
  | DisjE(Ax(Disj(p,q)), (pl, rl),(pr, rr)) -> let (bdisj, plubq) = checkValidityProof assump (Ax(Disj(p,q)))
    and (bl, left) = checkValidityProof (pl::assump) rl
    and (br, right) = checkValidityProof (pr::assump) rr
    in if (p=pl && q = pr && left = right)
    then (bdisj && bl && br, left)
    (* tu wryrzucamy że jest źle *)
    else (false, left)
  (* in if bdisj && bl && br
     then  *)
  | ImplE(Ax(p),Ax(Impl(p2, q))) ->
    if (p=p2)
    then (true, q)
    (* coś jest źle *)
    else (false, q)



  | _ -> (false, Bot)

let check proof = checkValidityProof [Top] proof


;;

check(Ax(Bot));;
check(ImplI(Conj(Var("a"), Impl(Var("a"),Var("b"))), Ax(Var("b"))));; *)
