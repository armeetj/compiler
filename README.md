# Racket Compiler

Racket to x86-64 nanopass Compiler written from scratch in OCaml.

Armeet Singh Jatyani `armeet@caltech.edu`

Ashug Gurijala `agurijal@caltech.edu`

## Architecture

The compiler is split into a backend (heavy reduction logic) and frontend (reduced languages to assembly with light optimizations).
- Backend
    - `uniquify` - ensure all let expressions have unique names
    - `reveal_functions` - replace any function name variables with FunRef form
    - `limit_functions` - in any function with more than 6 args, additional args are packaged into a tuple
    - `expose_allocation` - replace vector form with 3 lower level forms (collect, allocate, global_value) for garbage collection
    - `uncover_get`
    - `remove_complex` - transform all arithmetic operands into atomic expressions (Ints or Vars)
    - `explicate_control` - flattens nested let statements into sequential assignments followed by a final return
    - `remove_unused` - removes any jump blocks that can never be reached (full name remove unused blocks)
- Frontend
    - `select_instructions` - convert from intermediate language to assembly intermediate language
    - `uncover_live` - liveness analysis
    - `build_interference` - interference graph coloring algorithm for liveness analysis
    - `allocate_registers` - allocate registers as determined by graph coloring algorithm
    - `remove_jumps` - optimization: if a block only ever jumps to another, merge them
    - `patch_instructions` - "patch" x86 instructions to follow restrictions (types, parameter types, order of operands)
    - `prelude_conclusion` - converts from the x86int language to the x86asm language (Sexp will be used to convert to string expressions)
    - `optimize` - remove instructions with no effect (adding/removing 0 from register/stack location, self-moves, etc.), trim reciprocal moves or identical moves

We implement a nanopass compiler, meaning we gradually convert higher-level languages into lower-level ones.
Each pass implements a small reduction. For example, the `remove_complex` (remove complex operands) pass, ensures that
operands of arithmetic expressions are atomic expressions such as integers or variables. The `uniquify` pass ensures that
variables have unique names. The `graph_coloring` and `allocate_registers`
passes dynamically allocate registers to variables, keeping track of live variables. Specifically, this pass keeps track of callee-saved
and caller-saved variables to perform liveness analysis. When registers are exhausted, variables are 
allocated on the stack.


## Setup
`opam install ocamlfind dune utop sexplib ppx_sexp_conv ocaml-lsp-server`

## Build
```bash
cd compiler
make
```

## Tests
`python scripts/run_eval_tests.py tests/var_test_10.src`

## All Tests
`python scripts/run_eval_tests.py tests/var_test_*.src`

## Compare
View compiled code and reference side by side.

### Random Sample
`python scripts/compare.py reference/var_test_*.lvar -diff -random 10`

### All Samples
`python scripts/compare.py reference/var_test_*.lvar -diff`

### Write output into file
`python scripts/compare.py reference/var_test_*.lvar -diff` > file.s
