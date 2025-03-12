# Run all single-pass comparison tests in order.
# usage: sh scripts/run_all_compare_tests.sh

echo Press "<return>" to advance...

echo
echo "Type checker 1" tests:
read
python scripts/compare.py reference/function*.lfun -diff

echo
echo "Shrink" tests:
read
python scripts/compare.py reference/function*.tc1 -diff

echo
echo "Uniquify" tests:
read
python scripts/compare.py reference/function*.sh -diff

echo
echo "Reveal functions" tests:
read
python scripts/compare.py reference/function*.un -diff

echo
echo "Limit functions" tests:
read
python scripts/compare.py reference/function*.rf -diff

echo
echo "Type checker 1b" tests:
read
python scripts/compare.py reference/function*.lf -diff

echo
echo "Expose allocation" tests:
read
python scripts/compare.py reference/function*.tc1b -diff

echo
echo "Uncover get" tests:
read
python scripts/compare.py reference/function*.ea -diff

echo
echo "Remove complex operands" tests:
read
python scripts/compare.py reference/function*.ug -diff

echo
echo "Explicate control" tests:
read
python scripts/compare.py reference/function*.rc -diff

echo
echo "Type checker 2" tests:
read
python scripts/compare.py reference/function*.ec -diff

echo
echo "Remove unused" tests:
read
python scripts/compare.py reference/function*.tc2 -diff

echo
echo "Select instructions" tests:
read
python scripts/compare.py reference/function*.ru -diff

echo
echo "Uncover live" tests:
read
python scripts/compare.py reference/function*.si -diff

echo
echo "Build interference" tests:
read
python scripts/compare.py reference/function*.ul -diff

echo
echo "Allocate registers" tests:
read
python scripts/compare.py reference/function*.bi* -diff

echo
echo "Remove jumps" tests:
read
python scripts/compare.py reference/function*.ar* -diff

echo
echo "Patch instructions" tests:
read
python scripts/compare.py reference/function*.rj* -diff

echo
echo "Prelude and conclusion" tests:
read
python scripts/compare.py reference/function*.pi* -diff

echo
echo "Optimize" tests:
read
python scripts/compare.py reference/function*.pc* -diff

echo
echo "Print assembly" tests:
read
python scripts/compare.py reference/function*.opt* -diff
echo

