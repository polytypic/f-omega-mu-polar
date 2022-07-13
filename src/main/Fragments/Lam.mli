open StdlibPlus
open Rea
include module type of LamT

val map_er'4 :
  ann:('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
  exp:('x21 -> ('R, 'e, 'x22, 'D) er) ->
  typ:('x31 -> ('R, 'e, 'x32, 'D) er) ->
  exp_var:('x41 -> ('R, 'e, 'x42, 'D) er) ->
  [< ('x11, 'x21, 'x31, 'x41) f'4] ->
  ('R, 'e, [> ('x12, 'x22, 'x32, 'x42) f'4], 'D) er

val to_is_free :
  map_er:
    ('exp ->
    ((bool Constant.r as 'R), 'e, 'exp2, (('R, 'D) applicative' as 'D)) er)
    uop ->
  var_eq:'exp_var bpr ->
  'exp_var ->
  ([> ('ann, 'exp, 'typ, 'exp_var) f'4] as 'exp) ->
  bool
