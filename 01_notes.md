- `Z` followed by an operation is zipWith
- `[]` with operation inside is fold (reduce)
- instead of `$*IN.lines` we can simply use `lines`
  (which is, in fact, `$*ARGFILES.lines`, the same as Perl's `<>`)
- `(lines) X (1, 3)` is a Seq of `((line1, 1), (line1, 3), (line2, 1), ...)`;
  to create a `((all lines, 1), (all lines, 2))`
  we need to use `(lines,) X (1, 3)`
- the index operator `[]` can be called using method notation,
  thus allowing to write `.[0]` instead of `$_[0]`
