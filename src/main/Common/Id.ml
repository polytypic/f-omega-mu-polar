open Rea
open StdlibPlus

module Name = struct
  type t = string

  module WeakSet = Weak.Make (struct
    type t = string

    let equal = ( = )
    let hash = Hashtbl.hash
  end)

  let weak_set = WeakSet.create 251

  let of_string name =
    match WeakSet.find_opt weak_set name with
    | None ->
      WeakSet.add weak_set name;
      name
    | Some name -> name

  let to_string = id

  (* *)

  let equal = ( == )
  let compare = String.compare

  (* *)

  let underscore = of_string "_"
end

module type S = sig
  type t = {name : Name.t; n : int; at : Loc.t}

  val at : t -> Loc.t
  val set_at : Loc.t -> t -> t

  (* *)

  val counter : t -> int
  val set_counter : int -> t -> t

  (* *)

  val name : t -> Name.t

  (* Special *)

  val is_numeric : t -> bool
  val is_underscore : t -> bool

  (* Comparison *)

  val equal : t -> t -> bool
  val compare : t -> t -> int

  (* Formatting *)

  val to_string : t -> string

  (* Constructors *)

  val underscore : Loc.t -> t
  val of_string : Loc.t -> string -> t
  val of_name : Loc.t -> Name.t -> t
  val of_number : Loc.t -> Bigint.t -> t

  (* Freshening *)

  val smallest :
    (t -> ('R, 'e, bool, (('R, 'D) #monad' as 'D)) er) ->
    t ->
    ('R, 'e, t, 'D) er
end

module Make () : S = struct
  type t = {name : Name.t; n : int; at : Loc.t}

  let at {at; _} = at
  let set_at at {name; n; _} = {at; name; n}

  (* *)

  let counter {n; _} = n
  let set_counter n t = {t with n}

  (* *)

  let name {name; _} = name

  (* *)

  let is_numeric {name; _} =
    let s = Name.to_string name in
    0 < String.length s && '0' <= s.[0] && s.[0] <= '9'

  let is_underscore {name; _} = Name.underscore == name

  (* *)

  let equal lhs rhs = lhs.name == rhs.name && lhs.n = rhs.n

  let compare lhs rhs =
    Name.compare lhs.name rhs.name <>? fun () -> Int.compare lhs.n rhs.n

  (* *)

  let to_string {name; n; _} =
    let it = Name.to_string name in
    if n = 0 then it else Printf.sprintf "%s$%d" it n

  (* *)

  let of_name at name = {name; n = 0; at}
  let of_string at s = of_name at (Name.of_string s)
  let of_number at n = of_string at (Bigint.to_string n)
  let underscore at = of_name at Name.underscore

  (* *)

  let smallest is_free i =
    let rec loop c =
      let u = set_counter c i in
      is_free u >>= function false -> return u | true -> loop (c + 1)
    in
    loop 0
end
