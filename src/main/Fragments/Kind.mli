open Rea
include module type of KindT

val map_er'3 :
  ann:('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
  kind:('x21 -> ('R, 'e, 'x22, 'D) er) ->
  polar:('x31 -> ('R, 'e, 'x32, 'D) er) ->
  [< ('x11, 'x21, 'x31) f'3] ->
  ('R, 'e, [> ('x12, 'x22, 'x32) f'3], 'D) er
