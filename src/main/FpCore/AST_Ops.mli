open StdlibPlus
open AST

module Lam : sig
  open Lam

  val map_fr' :
    ('ann1 -> ('f, 'F, 'ann2) Applicative.fr) ->
    ('exp1 -> ('f, 'F, 'exp2) Applicative.fr) ->
    ('typ1 -> ('f, 'F, 'typ2) Applicative.fr) ->
    ('var1 -> ('f, 'F, 'var2) Applicative.fr) ->
    [< ('ann1, 'exp1, 'typ1, 'var1) f] ->
    ('f, 'F, [> ('ann2, 'exp2, 'typ2, 'var2) f]) Applicative.fr
end

module Mu : sig
  open Mu

  val map_fr' :
    ('ann1 -> ('f, 'F, 'ann2) Applicative.fr) ->
    ('exp1 -> ('f, 'F, 'exp2) Applicative.fr) ->
    [< ('ann1, 'exp1) f] ->
    ('f, 'F, [> ('ann2, 'exp2) f]) Applicative.fr
end

module Polar : sig
  open Polar

  val map_fr' :
    ('ann1 -> ('f, 'F, 'ann2) Applicative.fr) ->
    [< 'ann1 f] ->
    ('f, 'F, [> 'ann2 f]) Applicative.fr
end

module Kind : sig
  open Kind

  val map_fr' :
    ('ann1 -> ('f, 'F, 'ann2) Applicative.fr) ->
    ('kind1 -> ('f, 'F, 'kind2) Applicative.fr) ->
    ('polar1 -> ('f, 'F, 'polar2) Applicative.fr) ->
    [< ('ann1, 'kind1, 'polar1) f] ->
    ('f, 'F, [> ('ann2, 'kind2, 'polar2) f]) Applicative.fr
end

module For : sig
  open For

  module Typ : sig
    open Typ

    val map_fr' :
      ('ann1 -> ('f, 'F, 'ann2) Applicative.fr) ->
      ('typ1 -> ('f, 'F, 'typ2) Applicative.fr) ->
      [< ('ann1, 'typ1) f] ->
      ('f, 'F, [> ('ann2, 'typ2) f]) Applicative.fr
  end

  module Exp : sig
    open Exp

    val map_fr' :
      ('ann1 -> ('f, 'F, 'ann2) Applicative.fr) ->
      ('exp1 -> ('f, 'F, 'exp2) Applicative.fr) ->
      ('typ1 -> ('f, 'F, 'typ2) Applicative.fr) ->
      ('var1 -> ('f, 'F, 'var2) Applicative.fr) ->
      ('kind1 -> ('f, 'F, 'kind2) Applicative.fr) ->
      ('tyvar1 -> ('f, 'F, 'tyvar2) Applicative.fr) ->
      [< ('ann1, 'exp1, 'typ1, 'var1, 'kind1, 'tyvar1) f] ->
      ( 'f,
        'F,
        [> ('ann2, 'exp2, 'typ2, 'var2, 'kind2, 'tyvar2) f] )
      Applicative.fr
  end
end

module Row : sig
  open Row

  module Typ : sig
    open Typ

    val map_fr' :
      ('ann1 -> ('f, 'F, 'ann2) Applicative.fr) ->
      ('typ1 -> ('f, 'F, 'typ2) Applicative.fr) ->
      [< ('ann1, 'typ1) f] ->
      ('f, 'F, [> ('ann2, 'typ2) f]) Applicative.fr
  end

  module Exp : sig
    open Exp

    val map_fr' :
      ('ann1 -> ('f, 'F, 'ann2) Applicative.fr) ->
      ('exp1 -> ('f, 'F, 'exp2) Applicative.fr) ->
      [< ('ann1, 'exp1) f] ->
      ('f, 'F, [> ('ann2, 'exp2) f]) Applicative.fr
  end
end

module Typ : sig
  open Typ

  val map_fr' :
    ('ann1 -> ('f, 'F, 'ann2) Applicative.fr) ->
    ('typ1 -> ('f, 'F, 'typ2) Applicative.fr) ->
    ('kind1 -> ('f, 'F, 'kind2) Applicative.fr) ->
    ('tyvar1 -> ('f, 'F, 'tyvar2) Applicative.fr) ->
    [< ('ann1, 'typ1, 'kind1, 'tyvar1) f] ->
    ('f, 'F, [> ('ann2, 'typ2, 'kind2, 'tyvar2) f]) Applicative.fr

  val ann : ('ann, 'typ, 'kind, 'tyvar) f -> 'ann

  val set_ann :
    'ann2 -> ('ann1, 'typ, 'kind, 'tyvar) f -> ('ann2, 'typ, 'kind, 'tyvar) f

  val map_fr :
    ('typ1 -> ('f, 'F, 'typ2) Applicative.fr) ->
    [< ('ann, 'typ1, 'kind, 'tyvar) f] ->
    ('f, 'F, [> ('ann, 'typ2, 'kind, 'tyvar) f]) Applicative.fr
end

module Exp : sig
  open Exp

  val map_fr' :
    ('ann1 -> ('f, 'F, 'ann2) Applicative.fr) ->
    ('exp1 -> ('f, 'F, 'exp2) Applicative.fr) ->
    ('typ1 -> ('f, 'F, 'typ2) Applicative.fr) ->
    ('var1 -> ('f, 'F, 'var2) Applicative.fr) ->
    ('kind1 -> ('f, 'F, 'kind2) Applicative.fr) ->
    ('tyvar1 -> ('f, 'F, 'tyvar2) Applicative.fr) ->
    [< ('ann1, 'exp1, 'typ1, 'var1, 'kind1, 'tyvar1) f] ->
    ('f, 'F, [> ('ann2, 'exp2, 'typ2, 'var2, 'kind2, 'tyvar2) f]) Applicative.fr

  val ann : ('ann, 'exp, 'typ, 'var, 'kind, 'tyvar) f -> 'ann

  val set_ann :
    'ann2 ->
    ('ann1, 'exp, 'typ, 'var, 'kind, 'tyvar) f ->
    ('ann2, 'exp, 'typ, 'var, 'kind, 'tyvar) f

  val map_fr :
    ('exp1 -> ('f, 'F, 'exp2) Applicative.fr) ->
    [< ('ann, 'exp1, 'typ, 'var, 'kind, 'tyvar) f] ->
    ('f, 'F, [> ('ann, 'exp2, 'typ, 'var, 'kind, 'tyvar) f]) Applicative.fr
end
