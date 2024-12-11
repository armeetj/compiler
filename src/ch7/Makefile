#
# Makefile for ch7 library.
#

BUILD = ../_build/default/ch7

# All the passes students have to complete.
PASSES = \
  shrink uniquify \
  reveal_functions limit_functions \
  expose_allocation uncover_get \
  remove_complex explicate_control \
  remove_unused select_instructions \
  uncover_live build_interference \
  graph_coloring allocate_registers \
  remove_jumps patch_instructions \
  prelude_conclusion optimize

default: comp
all: clean comp

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
