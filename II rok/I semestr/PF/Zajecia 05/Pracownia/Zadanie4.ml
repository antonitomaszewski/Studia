type 'a form = Bool of bool
             | Var of bool * 'a
             | Or of 'a form * 'a form
             | And of 'a form * 'a form
             | Imp of 'a form * 'a form

type 'a proof =
    Proof of 'a proof list
  | Form of 'a form
  | Frame of 'a form * 'a proof


(* let andI = Proof([Form(Var(true, 'p'));
                  Form(Var(true, 'q'));
                  Form(And(Var(true, 'p'),Var(true,'q')))]) *)

type 'a varlist = Vars of 'a list * 'a list

let nxor b1 b2 = (b1 && b2) || ((not b1) && (not b2))

let rec varsF_ (form : 'a form) (parity : bool) (result : 'a varlist): 'a varlist =
  match form with
  | Bool _ -> Vars([],[])
  | Var(b,v) -> let Vars(tr,fs) = result in if nxor b parity then Vars(v::tr, fs) else Vars(tr, v::fs)
  | Or(f1,f2)
  | And(f1,f2) -> varsF_ f1 parity (varsF_ f2 parity result)
  | Imp(f1,f2) -> varsF_ f1 (not parity) (varsF_ f2 parity result)

let varsF form = let Vars(tr,fs) = (varsF_ form true (Vars([],[]))) and sorto = (fun a b -> if (a < b) then -1 else if (a=b) then 0 else 1)
  in Vars(List.sort_uniq sorto tr, List.sort_uniq sorto fs)
(* varsF (Imp(Var(true,'a'), Var(true,'b'))) *)

let rec varsP_ (proof  : 'a proof) (parity : bool) (result : 'a varlist) : 'a varlist =
  match proof with
  | Form(f) -> varsF_ f parity result
  | Proof(pr) -> List.fold_left (fun acc p -> varsP_ p parity acc) result pr
  | Frame(assump, pr) -> varsP_ pr parity (varsF_ assump (not parity) result)

let varsP proof = let Vars(tr,fs) = (varsP_ proof true (Vars([],[]))) and sorto = (fun a b -> if (a < b) then -1 else if (a=b) then 0 else 1)
  in Vars(List.sort_uniq sorto tr, List.sort_uniq sorto fs)

(* let frame = Proof([Frame([Form(And(Var(true, 'p'), Imp(Var(true, 'p'), Var(true, 'q'))));
                          Form(Var(true, 'p'));
                          Form(Imp(Var(true, 'p'), Var(true, 'q')));
                          Form(Var(true, 'q'))]);
                   Form(Imp((And(Var(true, 'p'), Imp(Var(true, 'p'), Var(true, 'q')))), Var(true, 'q')))]);; *)

(* varsP frame;;
   varsP (Proof([Form(Var(true,'a')); Form(Var(true,'b'));Form(And(Var(true,'a'),Var(true,'b')))]));;
   varsP (Proof([
    Frame([
        Form(Var(true,'a'));
        Form(Var(true,'b'))
      ]);
    Form(Imp(Var(true,'a'),Var(true,'b')))
   ]))
   ;; *)

let p = Proof([
    Frame(Var(true,'p'),
          Proof([Form(Var(true,'q'))]));
    Form(Imp(Var(true,'p'), Var(true,'q')))
  ]);;
varsP p

;;
