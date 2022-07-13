open Rea
include MuT

let map_er'2 ~ann ~exp = function
  | `Mu x -> map_er'2 ann exp x >>- fun x -> `Mu x
