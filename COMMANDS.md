# Tests
`python scripts/run_eval_tests.py tests/var_test_10.src`

## All Tests
`python scripts/run_eval_tests.py tests/var_test_*.src`

# Compare
View compiled code and reference side by side.

## Random Sample
`python scripts/compare.py reference/var_test_*.lvar -diff -random 10`

## All Samples
`python scripts/compare.py reference/var_test_*.lvar -diff`

# Write output into file
`python scripts/compare.py reference/var_test_*.lvar -diff` > file.s
