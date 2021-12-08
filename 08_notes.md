* `.antipairs` creates a reverse mapping, but calling it on a `Seq` of `Pair`s
  does not produce the expected result
* `.antipairs` can also be called on list-like things to produce a mapping
  of elements to their indices
* to convert `Pair`s to two-element lists, use `.kv`
* to initialise two arrays from a list of two lists, use `Z=`
  (otherwise, the first array gets the whole outer list and the second
   remains empty)
