open Rea
open StdlibPlus
include AnnotT

let map_er'3 ~ann ~exp ~typ = function
  | `Annot x -> map_er'3 ann exp typ x >>- fun x -> `Annot x

let opt at = Option.fold ~none:id ~some:(fun a x -> `Annot (at a, x, a))
