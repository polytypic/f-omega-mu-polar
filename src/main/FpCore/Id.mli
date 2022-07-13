open StdlibPlus

module Name : sig
  type t

  val of_string : string -> t
  val to_string : t -> string

  (* *)

  val equal : t bpr
  val compare : t cmp

  (* *)

  val underscore : t
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

  val smallest : (t -> ('f, 'F, bool) Monad.fr) -> t -> ('f, 'F, t) Monad.fr
end

module Make () : S
