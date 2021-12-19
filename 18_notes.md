- raku does not have a deepcopy builtin
  * some suggest using `.deepmap(*.clone)` but the result contains immutable
    values instead of scalars
  * solution: use `.deepmap: { my $_ = $_ }`
