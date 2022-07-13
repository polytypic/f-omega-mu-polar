open Rea
include LamT

let map_er'4 ~ann ~exp ~typ ~exp_var = function
  | `Lam x -> map_er'4 ann exp_var typ exp x >>- fun x -> `Lam x
  | `Var x -> map_er'2 ann exp_var x >>- fun x -> `Var x
  | `App x -> map_er'3 ann exp exp x >>- fun x -> `App x

let rec to_is_free ~map_er ~var_eq i' = function
  | `Lam (_, i, _, e) -> (not (var_eq i i')) && to_is_free ~map_er ~var_eq i' e
  | `Var (_, i) -> var_eq i i'
  | t -> Traverse.to_exists map_er (to_is_free ~map_er ~var_eq i') t
