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
