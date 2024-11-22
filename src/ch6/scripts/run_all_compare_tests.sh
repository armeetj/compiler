# Run all single-pass comparison tests in order.
# usage: sh scripts/run_all_compare_tests.sh

echo Press "<return>" to advance...

echo
echo "Type checker 1" tests:
read
python scripts/compare.py reference/vector*.ltup -diff

echo
echo "Shrink" tests:
read
python scripts/compare.py reference/vector*.tc1 -diff

echo
echo "Uniquify" tests:
read
python scripts/compare.py reference/vector*.sh -diff

echo
echo "Expose allocation" tests:
read
python scripts/compare.py reference/vector*.un -diff

echo
echo "Uncover get" tests:
read
python scripts/compare.py reference/vector*.ea -diff

echo
echo "Remove complex operands" tests:
read
python scripts/compare.py reference/vector*.ug -diff

echo
echo "Explicate control" tests:
read
python scripts/compare.py reference/vector*.rc -diff

echo
echo "Type checker 2" tests:
read
python scripts/compare.py reference/vector*.ec -diff

echo
echo "Remove unused" tests:
read
python scripts/compare.py reference/vector*.tc2 -diff

echo
echo "Select instructions" tests:
read
python scripts/compare.py reference/vector*.ru -diff

echo
echo "Uncover live" tests:
read
python scripts/compare.py reference/vector*.si -diff

echo
echo "Build interference" tests:
read
python scripts/compare.py reference/vector*.ul -diff

echo
echo "Allocate registers" tests:
read
python scripts/compare.py reference/vector*.bi* -diff

echo
echo "Remove jumps" tests:
read
python scripts/compare.py reference/vector*.ar* -diff

echo
echo "Patch instructions" tests:
read
python scripts/compare.py reference/vector*.rj* -diff

echo
echo "Prelude and conclusion" tests:
read
python scripts/compare.py reference/vector*.pi* -diff

echo
echo "Print assembly" tests:
read
python scripts/compare.py reference/vector*.pc* -diff
echo

