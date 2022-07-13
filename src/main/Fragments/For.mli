open Rea

module Typ : sig
  include module type of ForT.Typ

  val map_er'2 :
    ann:('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
    typ:('x21 -> ('R, 'e, 'x22, 'D) er) ->
    [< ('x11, 'x21) f'2] ->
    ('R, 'e, [> ('x12, 'x22) f'2], 'D) er
end

module Exp : sig
  include module type of ForT.Exp

  val map_er'6 :
    ann:('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
    exp:('x21 -> ('R, 'e, 'x22, 'D) er) ->
    typ:('x31 -> ('R, 'e, 'x32, 'D) er) ->
    exp_var:('x41 -> ('R, 'e, 'x42, 'D) er) ->
    kind:('x51 -> ('R, 'e, 'x52, 'D) er) ->
    typ_var:('x61 -> ('R, 'e, 'x62, 'D) er) ->
    [< ('x11, 'x21, 'x31, 'x41, 'x51, 'x61) f'6] ->
    ('R, 'e, [> ('x12, 'x22, 'x32, 'x42, 'x52, 'x62) f'6], 'D) er
end
