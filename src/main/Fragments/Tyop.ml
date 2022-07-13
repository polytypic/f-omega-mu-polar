open Rea
include TyopT

let map_er'2 ~ann ~typ = function
  | `Tyop x -> map_er'4 ann pure typ typ x >>- fun x -> `Tyop x
