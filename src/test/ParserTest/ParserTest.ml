open Rea
open MuTest
open Parser

let test_sig_parses_as name source check =
  test name @@ fun () ->
  source
  |> Run.parse_utf_8 Grammar.sigs Lexer.offside
  |> tryin (fun _ -> verify false) check

let () =
  test_sig_parses_as "basic" "{x: int} → ()" @@ function
  | `App (_, `App (_, `Var _, `Row (_, `Product, [(_, `Var _)])), `Var _) ->
    unit
  | _ -> verify false
