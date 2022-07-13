open Rea
include module type of InferT

val map_er'1 :
  ann:('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
  [< 'x11 f'1] ->
  ('R, 'e, [> 'x12 f'1], 'D) er
