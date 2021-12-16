- constructors: `new` needs to call `bless` which calls `BUILD`
- `while` loops in an expression return their last values in a `Seq`
  * be careful about laziness – assigning to an array forces eager evalutation
- `repeat while { ... }` works the same as `repeat { ... } while`,
  the condition is evaluated after the block
