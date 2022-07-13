open Rea
open StdlibPlus
include module type of RowT

val tuple : Loc.t -> 'a list -> 'a t
val product : Loc.t -> 'a t -> [> `Row of Loc.t * [> `Product] * 'a t]
val sum : Loc.t -> 'a t -> [> `Row of Loc.t * [> `Sum] * 'a t]

module Typ : sig
  include module type of RowT.Typ

  val map_er'2 :
    ann:('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
    typ:('x21 -> ('R, 'e, 'x22, 'D) er) ->
    [< ('x11, 'x21) f'2] ->
    ('R, 'e, [> ('x12, 'x22) f'2], 'D) er
end

module Exp : sig
  include module type of RowT.Exp

  val map_er'2 :
    ann:('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
    exp:('x21 -> ('R, 'e, 'x22, 'D) er) ->
    [< ('x11, 'x21) f'2] ->
    ('R, 'e, [> ('x12, 'x22) f'2], 'D) er
end
