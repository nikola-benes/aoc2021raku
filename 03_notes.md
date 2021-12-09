- own operators are easy to define and can even use letters in their name
- hyper operators:
  * `!«@r` negates all values in the array
  * `@s»[$p]` is `@s.map({ $_[$p] })`
- alternative notation for multiplication using `×`
  (might be good to avoid clash with other uses of `*`)
* `loop` is C-like `for`
* there are several xor(-like) operators:
  - `?^` the boolean xor (the right one here!)
  - `+^` the bit xor operation
  * `^` is a junction: `a ^ b ^ c` is `one(a, b, c)`
  * `^^` is a “short-circuiting xor”; once a second `True` is encountered
    in `a ^^ b ^^ c ^^ ...`, the result is `Nil`
* `do for` collects the last values in the cycle's body in a list
