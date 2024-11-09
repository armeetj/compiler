# Run all single-pass comparison tests in order.
# usage: sh scripts/run_all_compare_tests.sh

echo Press "<return>" to advance...

echo
echo "Type checker 1" tests:
read
python scripts/compare.py reference/cond*.lif -diff

echo
echo "Shrink" tests:
read
python scripts/compare.py reference/cond*.tc1 -diff

echo
echo "Uniquify" tests:
read
python scripts/compare.py reference/cond*.sh -diff

echo
echo "Remove complex operands" tests:
read
python scripts/compare.py reference/cond*.un -diff

echo
echo "Explicate control" tests:
read
python scripts/compare.py reference/cond*.rc -diff

echo
echo "Type checker 2" tests:
read
python scripts/compare.py reference/cond*.ec -diff

echo
echo "Remove unused" tests:
read
python scripts/compare.py reference/cond*.tc2 -diff

echo
echo "Select instructions" tests:
read
python scripts/compare.py reference/cond*.ru -diff

echo
echo "Uncover live" tests:
read
python scripts/compare.py reference/cond*.si -diff

echo
echo "Build interference" tests:
read
python scripts/compare.py reference/cond*.ul -diff

echo
echo "Allocate registers" tests:
read
python scripts/compare.py reference/cond*.bi* -diff

echo
echo "Remove jumps" tests:
read
python scripts/compare.py reference/cond*.ar* -diff

echo
echo "Patch instructions" tests:
read
python scripts/compare.py reference/cond*.rj* -diff

echo
echo "Prelude and conclusion" tests:
read
python scripts/compare.py reference/cond*.pi* -diff

echo
echo "Print assembly" tests:
read
python scripts/compare.py reference/cond*.pc* -diff
echo

