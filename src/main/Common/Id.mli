open Rea
open StdlibPlus

module Name : sig
  type t

  include EqualityType with type t := t
  include OrderedType with type t := t
  include StringableType with type t := t

  val of_string : string -> t

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

  include EqualityType with type t := t
  include OrderedType with type t := t

  (* Formatting *)

  include StringableType with type t := t

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

module Make () : S
