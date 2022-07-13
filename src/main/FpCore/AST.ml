open StdlibPlus

module Lam = struct
  type ('ann, 'exp, 'typ, 'var) f =
    [ `Lam of 'ann * 'var * 'typ * 'exp
    | `Var of 'ann * 'var
    | `App of 'ann * 'exp * 'exp ]
end

module Mu = struct
  type ('ann, 'exp) f = [`Mu of 'ann * 'exp]
end

module Polar = struct
  type 'ann f = [`None of 'ann | `Anti of 'ann | `Mono of 'ann | `Even of 'ann]
end

module Kind = struct
  type ('ann, 'kind, 'polar) f =
    [`Arrow of 'ann * 'kind * 'polar * 'kind | `Star of 'ann]
end

module For = struct
  module Typ = struct
    type ('ann, 'typ) f = [`For of 'ann * [`All | `Some] * 'typ]
  end

  module Exp = struct
    type ('ann, 'exp, 'typ, 'var, 'kind, 'tyvar) f =
      [ `Gen of 'ann * 'tyvar * 'kind * 'exp
      | `Inst of 'ann * 'exp * 'typ
      | `Pack of 'ann * 'typ * 'exp * 'typ
      | `Unpack of 'ann * 'tyvar * 'kind * 'var * 'exp * 'exp ]
  end
end

module Atom = struct
  type t = [`Nat of Loc.t * Bigint.t | `Text of Loc.t * string]
end

module Row = struct
  type 'typ t = (Atom.t * 'typ) list

  module Typ = struct
    type ('ann, 'typ) f = [`Row of 'ann * [`Product | `Sum] * 'typ t]
  end

  module Exp = struct
    type ('ann, 'exp) f =
      [ `Product of 'ann * 'exp t
      | `Select of 'ann * 'exp * 'exp
      | `Inject of 'ann * Atom.t * 'exp
      | `Case of 'ann * 'exp ]
  end
end

module Typ = struct
  type ('ann, 'typ, 'kind, 'tyvar) f =
    [ ('ann, 'typ, 'kind, 'tyvar) Lam.f
    | ('ann, 'typ) For.Typ.f
    | ('ann, 'typ) Mu.f
    | ('ann, 'typ) Row.Typ.f ]
end

module Exp = struct
  type ('ann, 'exp, 'typ, 'var, 'kind, 'tyvar) f =
    [ ('ann, 'exp, 'typ, 'var) Lam.f
    | ('ann, 'exp, 'typ, 'var, 'kind, 'tyvar) For.Exp.f
    | ('ann, 'exp) Mu.f
    | ('ann, 'exp) Row.Exp.f ]
end
