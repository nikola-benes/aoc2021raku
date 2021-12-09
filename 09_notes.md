- the difference between containerised and non-containerised lists
  plays a role in many situations and one needs to be very careful
  * `cont «+» non-cont` is cont.
  * `non-cont «+» cont` is not cont.
  * when using `@_` in a sub, cont. lists get expanded into `@_`,
    while non-cont. list is just one element of `@_`
  * it is perhaps better to use named arguments in subs
- (`Z` or `X`) and `«»` work differently in the presence of cont. lists
  * hyper-ops expand the cont. lists, `Z` and `X` do not
- hashes (and sethashes) still only work reasonably with numeric or string
  keys
  * although it is possible to have a `SetHash[List]`, it is not useful at all
    as each (cont.) list is considered to be different
