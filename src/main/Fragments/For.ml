open Rea
include ForT

module Typ = struct
  include Typ

  let map_er'2 ~ann ~typ = function
    | `For (a, q, t) -> ann a <*> typ t >>- fun (a, t) -> `For (a, q, t)
end

module Exp = struct
  include Exp

  let map_er'6 ~ann ~exp ~typ ~exp_var ~kind ~typ_var = function
    | `Gen x -> map_er'4 ann typ_var kind exp x >>- fun x -> `Gen x
    | `Inst x -> map_er'3 ann exp typ x >>- fun x -> `Inst x
    | `Pack x -> map_er'4 ann typ exp typ x >>- fun x -> `Pack x
    | `Unpack x ->
      map_er'6 ann typ_var kind exp_var exp exp x >>- fun x -> `Unpack x
end
