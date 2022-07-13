open Rea
open StdlibPlus
open Fragments

module Polar = struct
  include AstT.Polar
end

module Kind = struct
  include AstT.Kind

  let map_er'3 ~ann ~kind ~polar = function
    | #Kind.f'3 as k -> Kind.map_er'3 ~ann ~kind ~polar k

  (* *)

  let map_ann_er ann = map_er'3 ~ann ~kind:pure ~polar:pure
  let ann t = Traverse.to_get_opt map_ann_er t |> Option.get
  let set_ann at' = Traverse.to_set map_ann_er at'
end

module Typ = struct
  include AstT.Typ

  let map_er'4 ~ann ~typ ~kind ~typ_var = function
    | #For.Typ.f'2 as t -> For.Typ.map_er'2 ~ann ~typ t
    | #Lam.f'4 as t -> Lam.map_er'4 ~ann ~exp:typ ~typ:kind ~exp_var:typ_var t
    | #Mu.f'2 as t -> Mu.map_er'2 ~ann ~exp:typ t
    | #Row.Typ.f'2 as t -> Row.Typ.map_er'2 ~ann ~typ t

  let map_er typ = map_er'4 ~ann:pure ~typ ~kind:pure ~typ_var:pure

  (* *)

  let map_ann_er ann = map_er'4 ~ann ~typ:pure ~kind:pure ~typ_var:pure
  let ann t = Traverse.to_get_opt map_ann_er t |> Option.get
  let set_ann at' = Traverse.to_set map_ann_er at'

  (* *)

  let is_free i' = Lam.to_is_free ~map_er ~var_eq:Var.equal i'
end

module Exp = struct
  include AstT.Exp

  let map_er'6 ~ann ~exp ~typ ~exp_var ~kind ~typ_var = function
    | #For.Exp.f'6 as e ->
      For.Exp.map_er'6 ~ann ~exp ~typ ~exp_var ~kind ~typ_var e
    | #Lam.f'4 as e -> Lam.map_er'4 ~ann ~exp ~typ ~exp_var e
    | #Mu.f'2 as e -> Mu.map_er'2 ~ann ~exp e
    | #Row.Exp.f'2 as e -> Row.Exp.map_er'2 ~ann ~exp e

  let map_er exp =
    map_er'6 ~ann:pure ~exp ~typ:pure ~exp_var:pure ~kind:pure ~typ_var:pure

  (* *)

  let map_ann_er ann =
    map_er'6 ~ann ~exp:pure ~typ:pure ~exp_var:pure ~kind:pure ~typ_var:pure

  let ann t = Traverse.to_get_opt map_ann_er t |> Option.get
  let set_ann at' = Traverse.to_set map_ann_er at'

  (* *)

  let is_free i' = Lam.to_is_free ~map_er ~var_eq:Var.equal i'
end
