open Rea
include InferT

let map_er'1 ~ann = function `Infer x -> map_er'1 ann x >>- fun x -> `Infer x
