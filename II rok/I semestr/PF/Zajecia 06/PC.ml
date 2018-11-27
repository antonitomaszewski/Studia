open Syntax;;
type result = Error of string | Result of string prop
(* Zadanie 1 *)
let addAssumption p assumptions = p::assumptions

let rec checkProof (proof : string pt) (assumptions : string prop list) : result =
  match proof with
  | Ax _ -> ax proof assumptions
  | TopI -> topi
  | ConjI(_,_) -> conji proof assumptions
  | DisjIL(_,_) -> disjil proof assumptions
  | DisjIR(_,_) -> disjir proof assumptions
  | ImplI(_,_) -> impli proof assumptions

  | BotE _ -> bote proof
  | ConjEL _ -> conjel proof
  | ConjER _ -> conjer proof
  | DisjE (_,_,_) -> disje proof assumptions
  | ImplE (_,_) -> imple proof assumptions


and ax (Ax(f) : string pt) (assumptions : string prop list) : result =
  if List.mem f assumptions
  then Result f
  else Error "zmiennej nie ma w założeniach"

and topi : result =
  Result Top

and conji (ConjI(p,q) : string pt) (assumptions : string prop list) : result =
  let pres = checkProof p assumptions
  and qres = checkProof q assumptions
  in match pres,qres with
  | Error _ , _ -> pres
  | _, Error _ -> qres
  (* | _ -> Result(Conj(pres,qres)) *)
  | Result(p), Result(q) -> Result(Conj(p,q))

and disjil (DisjIL(p,q) : string pt) (assumptions : string prop list) : result =
  let pres = checkProof p assumptions
  in match pres with
  | Error _ -> pres
  | Result p -> Result(Disj(p,q))

and disjir (DisjIR(p,q) : string pt) (assumptions : string prop list) : result =
  let qres = checkProof q assumptions
  in match qres with
  | Error _ -> qres
  | Result q -> Result(Disj(p,q))

and impli (ImplI(p,q) : string pt) (assumptions : string prop list) : result =
  match checkProof q (addAssumption p assumptions) with
  | Error e -> Error e
  | Result f -> Result(Impl(p, f))



and bote (BotE(p) : string pt) : result =
  Result p

and conjel (ConjEL(conj) : string pt) : result =
  match conj with
  | Ax(Conj(p,q)) -> Result(p)
  | Ax(_) -> Error("oczekiwano koniuknkcji")
  | _ -> Error("oczekiwano formuły")

and conjer (ConjER(conj) : string pt) : result =
  match conj with
  | Ax(Conj(p,q)) -> Result(q)
  | Ax(_) -> Error("oczekiwano koniuknkcji")
  | _ -> Error("oczekiwano formuły")


and disje (DisjE(disj, h1, h2) : string pt) (assumptions : string prop list) : result =
  match disj,h1,h2 with
  | Ax(Disj(p,q)), (p2, d1), (q2, d2) ->
    if (p=p2)
    then if (q=q2)
      then let alt  = checkProof disj assumptions
        and r1 = checkProof d1 (addAssumption p2 assumptions)
        and r2 = checkProof d2 (addAssumption q2 assumptions)
        in match alt, r1, r2 with
        | Error _, _, _ -> alt
        | _ , Error _, _ -> r1
        | _, _, Error _ -> r2
        | _ when r1 = r2 -> r1
        | _ -> Error("DisjE r1 != r2")
      else Error("DisjE q != q2")
    else Error("DisjE p != p2")
  | Ax(d), _, _ -> Error("DisjE po lewej w środku powinna być alternatywa")
  | _, _, _ -> Error("DisjE po lewej powinna być formuła")

and imple (ImplE(p, pimpq) : string pt) (assumptions : string prop list) : result =
  (* match p,pimpq with
     | Ax(pres),Ax(Impl(pres2, q)) when pres = pres2 -> Result q
     | _ -> Error("ImplE pres != pres2") *)
  let pres = checkProof p assumptions
  and pimpqres = checkProof pimpq assumptions
  in  match pres, pimpqres with
  | Error _, _ -> pres
  | _, Error _ -> pimpqres
  | Result(p), Result(Impl(p2,q)) -> if (p = p2) then Result q else Error("ImplE p1 != pres")
  | _ -> Error("ImplE z prawej nie było implikacji")

let check (proof : string pt) : result = checkProof proof []


(* Zadanie 2 *)
let rec pdone (f : string prop) (assumptions : string prop list) : bool =
  (introduction f assumptions) ||
  (elimination f assumptions)
and introduction f assumptions =
  match f with
  | Top -> true
  | Var(v) -> List.mem f assumptions
  | Conj(p,q) -> (pdone p assumptions) && (pdone q assumptions)
  | Disj(p,q) -> (pdone p assumptions) || (pdone q assumptions)
  (* | Impl(p,q) -> List.mem q assumptions *)
  | Impl(p,q) -> pdone q (p::assumptions)

and elimination f assumptions =
  let rec funbot x assumptions =
    match assumptions with
    | [] -> false
    | Bot::_ -> true
    | _::xs -> funbot x xs
  and funvar x assumptions =
    match assumptions with
    | [] -> false
    | y::_ when x=y -> true
    | _::xs -> funvar x xs
  and funand x assumptions =
    match assumptions with
    | [] -> false
    | (Conj(y, _))::_ when x=y -> true
    | (Conj(_ ,y))::_ when x=y -> true
    | _::xs -> funand x xs

  and implikacjeWx x assumptions =
    match assumptions with
    | [] -> []
    | (Impl(p,y) as i)::xs when y=x ->  p::(implikacjeWx x xs)
    | _::xs -> implikacjeWx x xs
  and funimpl x assumptions =
    let imps = implikacjeWx x assumptions
    in let wynik = List.filter (fun b -> b) (List.map (fun p -> funvar p assumptions) imps)
    in if (List.length wynik) > 0
    then true
    else false
  and funor x assumptions =
    let imps = implikacjeWx x assumptions
    in let possibles = List.filter (fun (Disj(p,q)) -> not(p=q))
           (List.flatten (List.map (fun p -> List.map (fun q -> Disj(p,q)) imps) imps))
    in (List.length (List.filter (fun disj -> List.mem disj assumptions) possibles)) > 0
  in (funbot f assumptions)
     || (funvar f assumptions)
     || (funand f assumptions)
     || (funimpl f assumptions)
     || (funor f assumptions)



let rec checkPt proof gassumptions lassumptions =
  match proof with
  | PDone(f) -> if pdone f (lassumptions @ gassumptions)
    then (Result f, gassumptions)
    else Error("Bład formuła"), []
  | PConc(f, ps) -> if pdone f (lassumptions @ gassumptions)
    then checkPt ps (f::gassumptions) lassumptions
    else Error("PConc"), []
  | PHyp ((f,ps),res) -> let frame, axioms = checkPt ps (lassumptions @ gassumptions) (f::[])
    in match frame with
    | Error _ -> frame, axioms
    | Result r -> if not (PDone(Impl(f,r)) = res)
      then Error("Błąd w implikacji"),[]
      else checkPt res ((Impl(f,r)) :: gassumptions) lassumptions
(* | _ -> Error("W ramce dowodzimy implikacje"), [] *)
let rec printProp prop =
  match prop with
  | Bot -> print_string " Bot "
  | Top -> print_string " Top "
  | Var(a) -> (print_string (" "^a^" "))
  | Conj(p,q) -> print_string "(";  printProp p; print_string " ) i ( "; printProp q; print_string " ) "
  | Disj(p,q) -> print_string "(";  printProp p; print_string " ) lub ( "; printProp q; print_string " ) "
  | Impl(p,q) -> print_string "(";  printProp p; print_string " ) implikuje ( "; printProp q; print_string " ) "



let rec printPs ps =
  match ps with
  | PDone(f) -> print_string("[PDone "); printProp f; print_string("EPDone]")
  | PConc(f, ps) -> print_string("{PConc "); printProp f; printPs ps; print_string("EPConc}")
  | PHyp((f,psh),ps) -> print_string("{[(PHyp "); printProp f; print_string("EPhyp) "); printPs psh; print_string("EPHyp] "); printPs ps; print_string("EPHyp]}")








let sgoal s prop res = match res with
  | Result r, axioms -> if r=prop then  s^" T" else s^ " F"
  (* | Result r -> if (prop = r) then s^" T " else s^" F " *)
  | Error e, axioms -> s ^ " " ^ e

let check_thing thing =
  match thing with
  | SGoal(s, prop, ps) -> sgoal s prop (checkPt ps [] [])
  (* | SGoal(_, prop, ps) -> printPs ps; " " *)
  (* | SGoal(_, prop, _) -> printProp prop; " " *)
  (* | SGoal(_, _, _) -> "not implemented yet" *)
  | TGoal(s, prop, pt) -> match (check pt) with
    | Error e -> s ^ " " ^ e
    | Result r -> if (prop = r) then s^" T" else s^" F"
(* | Result r -> printProp r; " " *)
(* | _ -> (printProp prop); "asd" *)


let _ =
  let lexbuf = Lexing.from_channel stdin in
  let proofs = Parser.file Lexer.token lexbuf
  (* powyższe wiersze wczytują listę dowodów ze standardowego wejścia
     i parsują ją do postaci zdefiniowanej w module Syntax *)
  in List.iter (fun t -> print_string (check_thing t); print_newline ()) proofs; print_newline ()
