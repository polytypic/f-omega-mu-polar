open Rea
include PolarT

let map_er'1 ~ann = function
  | `None a -> ann a >>- fun x -> `None x
  | `Anti a -> ann a >>- fun x -> `Anti x
  | `Mono a -> ann a >>- fun x -> `Mono x
  | `Even a -> ann a >>- fun x -> `Even x
