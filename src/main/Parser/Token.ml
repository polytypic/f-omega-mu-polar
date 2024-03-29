open Grammar

let[@warning "-32"] to_string = function
  (*| And -> "and"*)
  | ArrowRight -> "→"
  | BraceLhs -> "{"
  | BraceLhsNS -> "{"
  | BraceRhs -> "}"
  (*| BracketLhs -> "["*)
  (*| BracketLhsNS -> "["*)
  (*| BracketRhs -> "]"*)
  (*| Caret -> "^"*)
  (*| Case -> "case"*)
  | Colon -> ":"
  | Comma -> ","
  | Comment _ -> "# ..."
  (*| Diamond -> "◇"*)
  | Dot -> "."
  (*| DoubleAngleQuoteLhs -> "«"*)
  (*| DoubleAngleQuoteLhsNS -> "«"*)
  (*| DoubleAngleQuoteRhs -> "»"*)
  (*| DoubleComma -> "„"*)
  | EOF -> "<EOF>"
  (*| Ellipsis -> "…"*)
  (*| Else -> "else"*)
  (*| Equal -> "="*)
  | Escape s -> s
  | Exists -> "∃"
  | ForAll -> "∀"
  (*| Greater -> ">"*)
  (*| GreaterEqual -> "≥"*)
  | Id id -> id
  | IdDollar id -> id
  | IdSub id -> id
  | IdTyp id -> id
  (*| If -> "if"*)
  (*| Import -> "import"*)
  (*| In -> "in"*)
  (*| Include -> "include"*)
  | LambdaLower -> "λ"
  (*| LambdaUpper -> "Λ"*)
  (*| Less -> "<"*)
  (*| LessEqual -> "≤"*)
  (*| Let -> "let"*)
  | LitNat n -> Bigint.to_string n
  (*| Local -> "local"*)
  | LogicalAnd -> "∧"
  (*| LogicalNot -> "¬"*)
  | LogicalOr -> "∨"
  (*| Minus -> "-"*)
  | MuLower -> "μ"
  (*| NotEqual -> "≠"*)
  | ParenLhs -> "("
  | ParenLhsNS -> "("
  | ParenRhs -> ")"
  (*| Percent -> "%"*)
  | Pipe -> "|"
  (*| Plus -> "+"*)
  (*| Semicolon -> ";"*)
  (*| Slash -> "/"*)
  | Star -> "*"
  (*| Target -> "target"*)
  (*| Then -> "then"*)
  | Tick -> "'"
  (*| TriangleLhs -> "◁"*)
  (*| TriangleRhs -> "▷"*)
  | TstrClose -> "\"...\""
  (*| TstrEsc _ -> "\"...\""*)
  (*| TstrOpen _ -> "\"...\""*)
  | TstrOpenRaw -> "\"...\""
  | TstrStr _ -> "\"...\""
  (*| TstrStrPart -> "\"...\""*)
  (*| Type -> "type"*)
  | Underscore -> "_"
