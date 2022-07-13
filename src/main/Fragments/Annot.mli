open Rea
include module type of AnnotT

val map_er'3 :
  ann:('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
  exp:('x21 -> ('R, 'e, 'x22, 'D) er) ->
  typ:('x31 -> ('R, 'e, 'x32, 'D) er) ->
  [< ('x11, 'x21, 'x31) f'3] ->
  ('R, 'e, [> ('x12, 'x22, 'x32) f'3], 'D) er

val opt :
  ('typ -> 'ann) -> 'typ option -> 'exp -> ([> ('ann, 'exp, 'typ) f'3] as 'exp)
