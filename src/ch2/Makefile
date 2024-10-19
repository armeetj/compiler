#
# Makefile for ch2 library.
#

BUILD = ../_build/default/ch2

PASSES = \
  uniquify remove_complex explicate_control \
  select_instructions assign_homes patch_instructions \
  prelude_conclusion

comp:
	dune build
	rm -f compile
	cp ${BUILD}/compile.bc compile
	chmod a+x compile

repl:
	utop -init ./utop_init

clean:
	dune clean
	rm -f compile

lines:
	@python3 ../scripts/count_lines.py ${PASSES}
