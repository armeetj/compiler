#
# Makefile for ch3 library.
#

BUILD = ../_build/default/ch3

# Only include code that students have to modify.
PASSES = \
  graph_coloring \
  uniquify remove_complex explicate_control \
  select_instructions build_interference \
  allocate_registers patch_instructions \
  prelude_conclusion

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
	@wc -l $(addsuffix ".ml", ${PASSES})
