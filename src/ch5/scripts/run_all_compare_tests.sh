# Run all single-pass comparison tests in order.
# usage: sh scripts/run_all_compare_tests.sh

echo Press "<return>" to advance...

echo
echo "Type checker 1" tests:
read
python scripts/compare.py reference/loop*.lwhile -diff

echo
echo "Shrink" tests:
read
python scripts/compare.py reference/loop*.tc1 -diff

echo
echo "Uniquify" tests:
read
python scripts/compare.py reference/loop*.sh -diff

echo
echo "Uncover get!" tests:
read
python scripts/compare.py reference/loop*.un -diff

echo
echo "Remove complex operands" tests:
read
python scripts/compare.py reference/loop*.ug -diff

echo
echo "Explicate control" tests:
read
python scripts/compare.py reference/loop*.rc -diff

echo
echo "Type checker 2" tests:
read
python scripts/compare.py reference/loop*.ec -diff

echo
echo "Remove unused" tests:
read
python scripts/compare.py reference/loop*.tc2 -diff

echo
echo "Select instructions" tests:
read
python scripts/compare.py reference/loop*.ru -diff

echo
echo "Uncover live" tests:
read
python scripts/compare.py reference/loop*.si -diff

echo
echo "Build interference" tests:
read
python scripts/compare.py reference/loop*.ul -diff

echo
echo "Allocate registers" tests:
read
python scripts/compare.py reference/loop*.bi* -diff

echo
echo "Remove jumps" tests:
read
python scripts/compare.py reference/loop*.ar* -diff

echo
echo "Patch instructions" tests:
read
python scripts/compare.py reference/loop*.rj* -diff

echo
echo "Prelude and conclusion" tests:
read
python scripts/compare.py reference/loop*.pi* -diff

echo
echo "Print assembly" tests:
read
python scripts/compare.py reference/loop*.pc* -diff
echo

