type ('ann, 'typ) f'2 =
  [`Tyop of 'ann * [`Join | `Meet | `Eq | `Merge] * 'typ * 'typ]
