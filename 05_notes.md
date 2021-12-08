- using `comb` is a nice way of parsing the input, no matter the various
  separators
- the sequence op `...` does the right thing for decreasing sequences
  * `3 ... 1` is `3 2 1`
- both the range op `..` and the sequence op `...` work strangely
  with strings *of the same length*
  * `"ab" .. "bc"` is `ab ac bb bc`, not `ab ac ad ... az ba bb bc`
    as in Perl, although the docs claim that `..` works as in Perl
  - this is also true when the strings are numeric,
    so `"12" .. "23"` is `12 13 22 23` :-(
  * the docs claim that the default generator for `...`
    is either `*.succ` or `*.pred`, which is not true:
    `"12", *.succ ... "23"` is different from `"12" ... "23"`
  * <https://stackoverflow.com/questions/70239228>
