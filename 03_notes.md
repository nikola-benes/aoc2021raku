- own operators are easy to define and can even use letters in their name
- hyper operators:
  * `!«@r` negates all values in the array
  * `@s»[$p]` is `@s.map({ $_[$p] })`
- alternative notation for multiplication using `×`
  (might be good to avoid clash with other uses of `*`)
* `loop` is C-like `for`
* `+^` is the bit xor operation and was the only version of xor
  that worked here
  * `^` is a junction
  * `^^` should be logical xor, but `True ^^ True` is `Nil`, not `False`
    (and `Nil` cannot be compared to `False` using `==`) :-(
* `do for` collects the last values in the cycle's body in a list
