open Rea
include KindT

let map_er'3 ~ann ~kind ~polar = function
  | `Arrow (a, d, p, c) ->
    tuple'4 (ann a) (kind d) (polar p) (kind c) >>- fun x -> `Arrow x
  | `Star a -> ann a >>- fun x -> `Star x
