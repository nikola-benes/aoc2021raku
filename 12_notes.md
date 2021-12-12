- `state` variables and the fact that the last expression is automatically
  `return`ed make writing memoized functions easy;
  however, the same result can be obtained by `use experimental :cached`
  and `sub … is cached`
