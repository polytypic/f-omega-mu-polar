module Typ = struct
  type ('ann, 'typ) f'2 = [`For of 'ann * [`All | `Some] * 'typ]
end

module Exp = struct
  type ('ann, 'exp, 'typ, 'exp_var, 'kind, 'typ_var) f'6 =
    [ `Gen of 'ann * 'typ_var * 'kind * 'exp
    | `Inst of 'ann * 'exp * 'typ
    | `Pack of 'ann * 'typ * 'exp * 'typ
    | `Unpack of 'ann * 'typ_var * 'kind * 'exp_var * 'exp * 'exp ]
end
