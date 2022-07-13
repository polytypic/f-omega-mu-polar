include SymbolT

let compare l r =
  match (l, r) with
  | `Nat (_, l), `Nat (_, r) -> Bigint.compare l r
  | `Text (_, l), `Text (_, r) -> String.compare l r
  | `Nat _, `Text _ -> -1
  | `Text _, `Nat _ -> 1

let at = function `Nat (a, _) | `Text (a, _) -> a
