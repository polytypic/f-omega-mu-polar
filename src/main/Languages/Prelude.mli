open Fragments

module Typ : sig
  module Var : sig
    include Common.Id.S

    val to_symbol : t -> Symbol.t

    (* *)

    val unit : t
    val arrow : t
  end
end

module Exp : sig
  module Var : sig
    include Common.Id.S

    val to_symbol : t -> Symbol.t
  end
end
