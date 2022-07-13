type ('ann, 'exp, 'typ, 'exp_var) f'4 =
  [ `Lam of 'ann * 'exp_var * 'typ * 'exp
  | `Var of 'ann * 'exp_var
  | `App of 'ann * 'exp * 'exp ]
