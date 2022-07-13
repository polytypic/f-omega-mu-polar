open Rea
open StdlibPlus
include RowT

let map_er typ = List.map_er (Pair.map_er return typ)

(* *)

let tuple at' = List.mapi (fun i t -> (`Nat (at', Bigint.of_int (i + 1)), t))
let sort symbols = List.sort (Compare.the fst Symbol.compare) symbols
let row at' m fs = `Row (at', m, sort fs)
let product at' = row at' `Product
let sum at' = row at' `Sum

module Typ = struct
  include RowT.Typ

  let map_er'2 ~ann ~typ = function
    | `Row (a, m, ts) ->
      ann a <*> map_er typ ts >>- fun (a, ts) -> `Row (a, m, ts)
end

module Exp = struct
  include RowT.Exp

  let map_er'2 ~ann ~exp = function
    | `Product x -> map_er'2 ann (map_er exp) x >>- fun x -> `Product x
    | `Select x -> map_er'3 ann exp exp x >>- fun x -> `Select x
    | `Inject (a, c, v) -> ann a <*> exp v >>- fun (a, v) -> `Inject (a, c, v)
    | `Case x -> map_er'2 ann exp x >>- fun x -> `Case x
end
