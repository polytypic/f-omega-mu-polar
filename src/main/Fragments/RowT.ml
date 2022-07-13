type 'typ t = (Symbol.t * 'typ) list

module Typ = struct
  type ('ann, 'typ) f'2 = [`Row of 'ann * [`Product | `Sum] * 'typ t]
end

module Exp = struct
  type ('ann, 'exp) f'2 =
    [ `Product of 'ann * 'exp t
    | `Select of 'ann * 'exp * 'exp
    | `Inject of 'ann * Symbol.t * 'exp
    | `Case of 'ann * 'exp ]
end
