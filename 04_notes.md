- routines like map and comb return `Seq`s, not lists, and `Seq`
  iterators cannot be used multiple times;
  to reuse `Seq`s, we need to convert them into lists or arrays
- array elements are containerised and containerised Lists are protected
  against `.flat`;
  calling `.List` on an array decontainerises its elements
- `SetHash` is a mutable set, but is still a kind of hash
  * to get the elements, we need to use `.keys`
* set operations can be written in unicode and can work with arbitrary
  list-like data
  * the result seems to be a `Set` unless the left operand is a `SetHash`
* although the docs claim that `gather` is forced to be lazy if bound
  to a scalar or sigilless variable, there is still a difference
  between `gather` and `lazy gather` in this case
  * `gather` is lazy in the sense that it produces the values on the fly,
    but `.is-lazy` returns `False` and we can call `.tail` and `[*-1]`
    on the result
  * calling `.is-lazy` on `lazy gather` returns `True`;
    `.tail` and `[*-1]` fail :-(
  * <https://stackoverflow.com/questions/70228056>
  * the two kinds of laziness also exist for sequences build with `...`
    and perhaps other `Seq`s
