#
# Makefile for ch5 library.
#

BUILD = ../_build/default/ch5

# Only include code that students have to modify.
PASSES = \
  shrink uniquify uncover_get \
  remove_complex explicate_control \
  remove_unused select_instructions \
  uncover_live build_interference \
  graph_coloring allocate_registers \
  patch_instructions prelude_conclusion

comp:
	dune build
	cp ${BUILD}/compile.bc compile
	chmod 755 compile

repl:
	utop -init ./utop_init

clean:
	dune clean
	rm -f compile
	rm -f *.o *.s

lines:
	@python3 ../scripts/count_lines.py ${PASSES}
