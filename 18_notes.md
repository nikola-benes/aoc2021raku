- raku does not have a deepcopy builtin
  * some suggest using `.deepmap(*.clone)` but the result contains immutable
    values instead of scalars
  * solution: use `.deepmap: { my $_ = $_ }`
  * using `.raku.EVAL` works as well but is much, *much* slower
