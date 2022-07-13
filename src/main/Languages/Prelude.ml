open StdlibPlus
open Common

module Typ = struct
  module Var = struct
    include Id.Make ()

    let to_symbol i = `Text (at i, Id.Name.to_string (name i))

    (* *)

    let mk name = of_name (Loc.of_path "prelude") (Id.Name.of_string name)
    let unit = mk "()"
    let arrow = mk "→"
  end
end

module Exp = struct
  module Var = struct
    include Id.Make ()

    let to_symbol i = `Text (at i, Id.Name.to_string (name i))
  end
end
