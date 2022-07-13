open StdlibPlus
include module type of SymbolT

val compare : t cmp
val at : t -> Loc.t
