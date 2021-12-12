- `state` variables and the fact that the last expression is automatically
  `return`ed make writing memoized functions easy;
  however, the same result can be obtained by `use experimental :cached`
  and `sub … is cached`
- it seems that `is cached` works similarly to my solution –
  including the subtle bug concerning hash-like things:
  * the order of keys in hashes may differ between instances;
    repeated evaluations of `<1 2 3>.Set.Str` return various permutations
    of the elements
  * `is cached` seems to rely on stringification (perhaps something more
    clever than my attempt, like using `.raku`), which then fails to cache
    sets, hashes etc. sometimes
