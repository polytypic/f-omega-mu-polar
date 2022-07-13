open StdlibPlus
open Fragments

module Polar = struct
  type 'ann f'1 = ['ann Ast.Polar.f'1 | 'ann Infer.f'1]
  type t = Loc.t f'1
end

module Kind = struct
  type ('ann, 'kind, 'polar) f'3 =
    [('ann, 'kind, 'polar) Ast.Kind.f'3 | 'ann Infer.f'1]

  type t = (Loc.t, t, Polar.t) f'3
end

module Typ = struct
  module Var = Prelude.Typ.Var

  type ('ann, 'typ, 'kind, 'typ_var) f'4 =
    [ ('ann, 'typ, 'kind, 'typ_var) Ast.Typ.f'4
    | ('ann, 'typ) Tyop.f'2
    | ('ann, 'typ, 'kind) Annot.f'3
    | 'ann Infer.f'1 ]

  type t = (Loc.t, t, Kind.t, Var.t) f'4
end

module Exp = struct
  module Var = Prelude.Exp.Var

  type ('ann, 'exp, 'typ, 'exp_var, 'kind, 'typ_var) f'6 =
    [ | ('ann, 'exp, 'typ, 'exp_var, 'kind, 'typ_var) Ast.Exp.f'6]

  type t = (Loc.t, t, Typ.t, Var.t, Kind.t, Typ.Var.t) f'6
end
