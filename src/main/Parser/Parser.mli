open Rea
open StdlibPlus
open Languages.Cst

module Buffer : sig
  type t

  val from_utf_8 : ?path:string -> string -> t
end

module Lexer : sig
  type t

  val plain : t
  val offside : t
  val is_id : string -> bool
  val is_id_or_nat : string -> bool
  val is_nat : string -> bool
  val coerce_to_id : string -> string
end

module Tokenizer : sig
  module State : sig
    type t

    val initial : t
  end

  type token_info = {begins : int; ends : int; name : string; state : State.t}

  val token_info_utf_8 : State.t -> string -> token_info
  val offset_as_utf_16 : string -> int -> int
  val offset_as_utf_32 : string -> int -> int
  val synonyms : < unicode : string ; ascii : string ; bop : bool > list
  val keywords : string list
  val pervasives : string list
  val identifiers : string -> string Seq.t
end

module Grammar : sig
  type 'a t

  val sigs : Typ.t t
end

module Run : sig
  module Error : sig
    type t = [`Error_lexeme of Loc.t * string | `Error_grammar of Loc.t * string]
  end

  val parse :
    'a Grammar.t ->
    Lexer.t ->
    Buffer.t ->
    ('R, [> Error.t], 'a, (('R, 'D) #sync' as 'D)) er

  val parse_utf_8 :
    'a Grammar.t ->
    Lexer.t ->
    ?path:string ->
    string ->
    ('R, [> Error.t], 'a, (('R, 'D) #sync' as 'D)) er
end
