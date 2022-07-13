open Rea
open StdlibPlus
open Fragments

module Polar = struct
  include CstT.Polar
end

module Kind = struct
  include CstT.Kind

  let map_er'3 ~ann ~kind ~polar = function
    | #Ast.Kind.f'3 as k -> Ast.Kind.map_er'3 ~ann ~kind ~polar k
    | #Infer.f'1 as k -> Infer.map_er'1 ~ann k

  (* *)

  let map_ann_er ann = map_er'3 ~ann ~kind:pure ~polar:pure
  let ann t = Traverse.to_get_opt map_ann_er t |> Option.get
  let set_ann at' = Traverse.to_set map_ann_er at'
end

module Typ = struct
  include CstT.Typ

  let map_er'4 ~ann ~typ ~kind ~typ_var = function
    | #Ast.Typ.f'4 as t -> Ast.Typ.map_er'4 ~ann ~typ ~kind ~typ_var t
    | #Tyop.f'2 as t -> Tyop.map_er'2 ~ann ~typ t
    | #Annot.f'3 as t -> Annot.map_er'3 ~ann ~exp:typ ~typ:kind t
    | #Infer.f'1 as t -> Infer.map_er'1 ~ann t

  let map_er typ = map_er'4 ~ann:pure ~typ ~kind:pure ~typ_var:pure

  (* *)

  let map_ann_er ann = map_er'4 ~ann ~typ:pure ~kind:pure ~typ_var:pure
  let ann t = Traverse.to_get_opt map_ann_er t |> Option.get
  let set_ann at' = Traverse.to_set map_ann_er at'

  (* *)

  let var i = `Var (Var.at i, i)
  let unit at' = `Var (at', Var.unit)
  let arrow at' d c = `App (at', `App (at', `Var (at', Var.arrow), d), c)
  let atom s = Symbol.at s |> fun at' -> Row.sum at' [(s, unit at')]

  let tuple at' = function
    | [] -> unit at'
    | [t] -> t
    | ts -> Row.product at' (Row.tuple at' ts)
end

module Exp = struct
  include CstT.Exp

  let map_er'6 ~ann ~exp ~typ ~exp_var ~kind ~typ_var = function
    | #Ast.Exp.f'6 as e ->
      Ast.Exp.map_er'6 ~ann ~exp ~typ ~exp_var ~kind ~typ_var e

  let map_er exp =
    map_er'6 ~ann:pure ~exp ~typ:pure ~exp_var:pure ~kind:pure ~typ_var:pure

  (* *)

  let map_ann_er ann =
    map_er'6 ~ann ~exp:pure ~typ:pure ~exp_var:pure ~kind:pure ~typ_var:pure

  let ann t = Traverse.to_get_opt map_ann_er t |> Option.get
  let set_ann at = Traverse.to_set map_ann_er at
end
