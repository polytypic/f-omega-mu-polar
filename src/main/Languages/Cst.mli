open Rea
open StdlibPlus
open Fragments

module Polar : sig
  include module type of CstT.Polar
end

module Kind : sig
  include module type of CstT.Kind

  val map_er'3 :
    ann:('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
    kind:('x21 -> ('R, 'e, 'x22, 'D) er) ->
    polar:('x31 -> ('R, 'e, 'x32, 'D) er) ->
    [< ('x11, 'x21, 'x31) f'3] ->
    ('R, 'e, [> ('x12, 'x22, 'x32) f'3], 'D) er

  (* *)

  val ann : ('ann, 'kind, 'polar) f'3 -> 'ann

  val set_ann :
    'ann2 -> ('ann1, 'kind, 'polar) f'3 -> ('ann2, 'kind, 'polar) f'3
end

module Typ : sig
  include module type of CstT.Typ

  val map_er'4 :
    ann:('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
    typ:('x21 -> ('R, 'e, 'x22, 'D) er) ->
    kind:('x31 -> ('R, 'e, 'x32, 'D) er) ->
    typ_var:('x41 -> ('R, 'e, 'x42, 'D) er) ->
    [< ('x11, 'x21, 'x31, 'x41) f'4] ->
    ('R, 'e, [> ('x12, 'x22, 'x32, 'x42) f'4], 'D) er

  val map_er :
    ('typ1 -> ('R, 'e, 'typ2, (('R, 'D) #applicative' as 'D)) er) ->
    ('ann, 'typ1, 'kind, 'typ_var) f'4 ->
    ('R, 'e, ('ann, 'typ2, 'kind, 'typ_var) f'4, 'D) er

  (* *)

  val ann : ('ann, 'typ, 'kind, 'typ_var) f'4 -> 'ann

  val set_ann :
    'ann2 ->
    ('ann1, 'typ, 'kind, 'typ_var) f'4 ->
    ('ann2, 'typ, 'kind, 'typ_var) f'4

  (* *)

  val var : Var.t -> [> `Var of Loc.t * Var.t]
  val unit : Loc.t -> [> `Var of Loc.t * Var.t]

  val atom :
    Symbol.t -> [> `Row of Loc.t * [> `Sum] * [> `Var of Loc.t * Var.t] Row.t]

  val tuple :
    Loc.t ->
    ([> `Var of Loc.t * Var.t | `Row of Loc.t * [> `Product] * 't Row.t] as 't)
    list ->
    't

  val arrow :
    Loc.t ->
    't ->
    't ->
    ([> `App of Loc.t * 't * 't | `Var of Loc.t * Var.t] as 't)
end

module Exp : sig
  include module type of CstT.Exp

  val map_er'6 :
    ann:('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
    exp:('x21 -> ('R, 'e, 'x22, 'D) er) ->
    typ:('x31 -> ('R, 'e, 'x32, 'D) er) ->
    exp_var:('x41 -> ('R, 'e, 'x42, 'D) er) ->
    kind:('x51 -> ('R, 'e, 'x52, 'D) er) ->
    typ_var:('x61 -> ('R, 'e, 'x62, 'D) er) ->
    [< ('x11, 'x21, 'x31, 'x41, 'x51, 'x61) f'6] ->
    ('R, 'e, [> ('x12, 'x22, 'x32, 'x42, 'x52, 'x62) f'6], 'D) er

  val map_er :
    ('exp1 -> ('R, 'e, 'exp2, (('R, 'D) #applicative' as 'D)) er) ->
    ('ann, 'exp1, 'typ, 'exp_var, 'kind, 'typ_var) f'6 ->
    ('R, 'e, ('ann, 'exp2, 'typ, 'exp_var, 'kind, 'typ_var) f'6, 'D) er

  (* *)

  val ann : ('ann, 'exp, 'typ, 'exp_var, 'kind, 'typ_var) f'6 -> 'ann

  val set_ann :
    'ann2 ->
    ('ann1, 'exp, 'typ, 'exp_var, 'kind, 'typ_var) f'6 ->
    ('ann2, 'exp, 'typ, 'exp_var, 'kind, 'typ_var) f'6
end
