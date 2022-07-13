open StdlibPlus

module Lam = struct
  let map_fr' ann exp typ var = function
    | `Lam (a, i, t, e) ->
      tuple'4 (ann a) (var i) (typ t) (exp e) >>- fun x -> `Lam x
    | `Var (a, i) -> tuple'2 (ann a) (var i) >>- fun x -> `Var x
    | `App (a, f, x) -> tuple'3 (ann a) (exp f) (exp x) >>- fun x -> `App x
end

module Mu = struct
  let map_fr' ann exp = function
    | `Mu (a, e) -> tuple'2 (ann a) (exp e) >>- fun x -> `Mu x
end

module Polar = struct
  let map_fr' ann = function
    | `None a -> ann a >>- fun x -> `None x
    | `Anti a -> ann a >>- fun x -> `Anti x
    | `Mono a -> ann a >>- fun x -> `Mono x
    | `Even a -> ann a >>- fun x -> `Even x
end

module Kind = struct
  let map_fr' ann kind polar = function
    | `Arrow (a, d, p, c) ->
      tuple'4 (ann a) (kind d) (polar p) (kind c) >>- fun x -> `Arrow x
    | `Star a -> ann a >>- fun x -> `Star x
end

module For = struct
  module Typ = struct
    let map_fr' ann typ = function
      | `For (a, q, t) -> ann a <*> typ t >>- fun (a, t) -> `For (a, q, t)
  end

  module Exp = struct
    let map_fr' ann exp typ var kind tyvar = function
      | `Gen (a, i, k, e) ->
        tuple'4 (ann a) (tyvar i) (kind k) (exp e) >>- fun x -> `Gen x
      | `Inst (a, e, t) -> tuple'3 (ann a) (exp e) (typ t) >>- fun x -> `Inst x
      | `Pack (a, t, e, x) ->
        tuple'4 (ann a) (typ t) (exp e) (typ x) >>- fun x -> `Pack x
      | `Unpack (a, t, k, i, v, e) ->
        tuple'6 (ann a) (tyvar t) (kind k) (var i) (exp v) (exp e) >>- fun x ->
        `Unpack x
  end
end

module Atom = struct end

module Row = struct
  let map_fr typ = List.map_fr (Pair.map_fr return typ)

  module Typ = struct
    let map_fr' ann typ = function
      | `Row (a, m, ts) ->
        ann a <*> map_fr typ ts >>- fun (a, ts) -> `Row (a, m, ts)
  end

  module Exp = struct
    let map_fr' ann exp = function
      | `Product (a, es) -> ann a <*> map_fr exp es >>- fun x -> `Product x
      | `Select (a, f, x) ->
        tuple'3 (ann a) (exp f) (exp x) >>- fun x -> `Select x
      | `Inject (a, c, v) -> ann a <*> exp v >>- fun (a, v) -> `Inject (a, c, v)
      | `Case (a, e) -> ann a <*> exp e >>- fun x -> `Case x
  end
end

module Typ = struct
  let map_fr' ann typ kind tyvar = function
    | #AST.Lam.f as t -> Lam.map_fr' ann typ kind tyvar t
    | #AST.For.Typ.f as t -> For.Typ.map_fr' ann typ t
    | #AST.Mu.f as t -> Mu.map_fr' ann typ t
    | #AST.Row.Typ.f as t -> Row.Typ.map_fr' ann typ t

  let map_ann_fr ann = map_fr' ann return return return
  let ann t = Traverse.to_get_opt map_ann_fr t |> Option.get
  let set_ann at = Traverse.to_set map_ann_fr at

  (* *)

  let map_fr typ = map_fr' return typ return return
end

module Exp = struct
  let map_fr' ann exp typ var kind tyvar = function
    | #AST.Lam.f as e -> Lam.map_fr' ann exp typ var e
    | #AST.For.Exp.f as e -> For.Exp.map_fr' ann exp typ var kind tyvar e
    | #AST.Mu.f as e -> Mu.map_fr' ann exp e
    | #AST.Row.Exp.f as e -> Row.Exp.map_fr' ann exp e

  let map_ann_fr ann = map_fr' ann return return return return return
  let ann t = Traverse.to_get_opt map_ann_fr t |> Option.get
  let set_ann at = Traverse.to_set map_ann_fr at

  (* *)

  let map_fr typ = map_fr' return typ return return return return
end
