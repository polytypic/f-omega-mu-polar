%token <Bigint.t> LitNat

//%token TstrStrPart

%token TstrOpenRaw
//%token <string> TstrOpen
%token <StdlibPlus.JsonString.t> TstrStr
//%token <string> TstrEsc
%token TstrClose

%token <string> Id
%token <string> IdDollar
%token <string> IdSub
%token <string> IdTyp

%token <string> Escape

%token <string> Comment

//%token And "and"
//%token Case "case"
//%token Else "else"
//%token If "if"
//%token Import "import"
//%token In "in"
//%token Include "include"
//%token Let "let"
//%token Local "local"
//%token Target "target"
//%token Then "then"
//%token Type "type"

%token ArrowRight "→"
%token BraceLhs "{"
%token BraceLhsNS "_{"
%token BraceRhs "}"
//%token BracketLhs "["
//%token BracketLhsNS "_["
//%token BracketRhs "]"
//%token Caret "^"
%token Colon ":"
%token Comma ","
//%token Diamond "◇"
%token Dot "."
//%token DoubleAngleQuoteLhs "«"
//%token DoubleAngleQuoteLhsNS "_«"
//%token DoubleAngleQuoteRhs "»"
//%token DoubleComma "„"
//%token Ellipsis "…"
//%token Equal "="
%token Exists "∃"
%token ForAll "∀"
//%token Greater ">"
//%token GreaterEqual "≥"
%token LambdaLower "λ"
//%token LambdaUpper "Λ"
//%token Less "<"
//%token LessEqual "≤"
%token LogicalAnd "∧"
//%token LogicalNot "¬"
%token LogicalOr "∨"
//%token Minus "-"
%token MuLower "μ"
//%token NotEqual "≠"
%token ParenLhs "("
%token ParenLhsNS "_("
%token ParenRhs ")"
//%token Percent "%"
%token Pipe "|"
//%token Plus "+"
//%token Semicolon ";"
//%token Slash "/"
%token Star "*"
%token Tick "'"
//%token TriangleLhs "◁"
//%token TriangleRhs "▷"
%token Underscore "_"

%token EOF

//%right "◁"
//%left "▷"
//%left "◇"
%left "∨"
%left "∧"
//%nonassoc "=" "≠" "»"
//%nonassoc "<" "≤" "≥" ">"
//%left "„"
//%left "+" "-" "^"
//%left "*" "/" "%"

%start <Typ.t> sigs

%{
    open StdlibPlus
    open Common
    open Fragments
    open Languages.Cst
%}

%%

list_rev_1(elem, sep):
  | e=elem                                          {[e]}
  | es=list_rev_1(elem, sep) sep e=elem             {e::es}

list_1(elem, sep):
  | es=list_rev_1(elem, sep)                        {List.rev es}

%inline list_n(elem, sep):
  |                                                 {[]}
  | es=list_rev_1(elem, sep)                        {List.rev es}

//

pre(prefix, elem):
  | e=preceded(prefix, elem)                        {e}

//

kind_atom:
  | "_"                                             {`Infer $loc}
  | "*"                                             {`Star $loc}
  | "(" k=kind ")"                                  {k}

kind:
  | k=kind_atom                                     {k}
  | d=kind_atom "→" c=kind                          {`Arrow ($loc, d, `Infer $loc, c)}

//

lab_lit:
  | n=LitNat                                        {`Nat ($loc, n)}
  | s=lit_string                                    {`Text ($loc, JsonString.to_utf8 s)}

lab:
  | l=lab_lit                                       {l}
  | i=exp_rid                                       {`Text ($loc, Id.Name.to_string (Exp.Var.name i))}

//

lit_string:
  | TstrOpenRaw s=TstrStr TstrClose                 {s}

//

typ_lab:
  | l=lab ":" t=typ                                 {(l, t)}
  | i=typ_rid                                       {(Typ.Var.to_symbol i, Typ.var i)}

typ_tick_lab:
  | "'" l=lab                                       {(l, Typ.unit $loc)}
  | "'" l=lab t=typ_atom_tick                       {(l, t)}
  | "'" l=lab t=typ_par("_{", "_(")                 {(l, t)}

typ_rid:
  | i=Id                                            {Typ.Var.of_string $loc i}
  | i=IdTyp                                         {Typ.Var.of_string $loc i}

typ_bid:
  | "_"                                             {Typ.Var.underscore $loc}
  | i=typ_rid                                       {i}

typ_pat:
  | i=typ_bid                                       {(i, `Infer $loc)}
  | i=typ_bid ":" k=kind                            {(i, k)}

typ_par(brace, paren):
  | brace fs=list_n(typ_lab, ",") ","? "}"          {Row.product $loc fs}
  | paren xs=list_n(typ, ",") ","? ")"              {Typ.tuple $loc xs}

typ_atom:
  | i=typ_rid                                       {Typ.var i}
  | t=typ_par("{", "(")                             {t}
  | f=typ_atom x=typ_par("_{", "_(")                {`App ($loc, f, x)}
  | "μ" "(" t=typ ")"                               {`Mu ($loc, t)}
  | "∃" "(" t=typ ")"                               {`For ($loc, `Some, t)}
  | "∀" "(" t=typ ")"                               {`For ($loc, `All, t)}

typ_tick:
  | "'" l=lab                                       {Typ.atom l}
  | "'" l=lab t=typ_par("_{", "_(")                 {Row.sum $loc [(l, t)]}

typ_atom_tick:
  | t=typ_atom                                      {t}
  | t=typ_tick                                      {t}

typ_app:
  | t=typ_atom                                      {t}
  | f=typ_app x=typ_atom_tick                       {`App ($loc, f, x)}

typ_inf:
  | "|"? s=list_1(typ_tick_lab, "|")                {Row.sum $loc s}
  | "|"                                             {Row.sum $loc []}
  | t=typ_app                                       {t}
  | l=typ_inf "∨" r=typ_inf                         {`Tyop ($loc, `Join, l, r)}
  | l=typ_inf "∧" r=typ_inf                         {`Tyop ($loc, `Meet, l, r)}

typ_arr:
  | t=typ_inf                                       {t}
  | d=typ_inf "→" c=typ_arr                         {Typ.arrow $loc d c}

typ_lam(head):
  | head b=typ_pat "." t=typ                        {`Lam ($loc, fst b, snd b, t)}

typ:
  | t=typ_arr k=pre(":", kind)?                     {Annot.opt Kind.ann k t}
  | t=typ_lam("μ")                                  {`Mu ($loc, t)}
  | t=typ_lam("∃")                                  {`For ($loc, `Some, t)}
  | t=typ_lam("∀")                                  {`For ($loc, `All, t)}
  | t=typ_lam("λ")                                  {t}

//

exp_rid:
  | i=Id                                            {Exp.Var.of_string $loc i}

//

sigs:
  | t=typ EOF                                       {t}
