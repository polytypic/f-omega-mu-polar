open StdlibPlus

type t = [`Nat of Loc.t * Bigint.t | `Text of Loc.t * string]
