open Rea
include module type of TyopT

val map_er'2 :
  ann:('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
  typ:('x21 -> ('R, 'e, 'x22, 'D) er) ->
  [< ('x11, 'x21) f'2] ->
  ('R, 'e, [> ('x12, 'x22) f'2], 'D) er
