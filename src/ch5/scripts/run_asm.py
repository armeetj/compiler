"""
run_asm.py:
    Run an assembly-language file and print out the output.
"""

import sys, re, glob, os.path
import subprocess as p
from subprocess import PIPE


verbose       = True
compile_arm64 = False
c_compiler    = 'gcc'
timeout       = 5  # seconds


class Error(Exception):
    """Exception class for compiler output errors."""
    pass


def run_assembly_program(progname, arm64=False):
    """
    Compile the program `progname` to assembly language.
    Also compile `runtime.c` and link to make an executable.
    If `arm64` is `True`, compile on an Apple Arm64 computer
    using Rosetta Stone.
    """
    basename = os.path.basename(progname)

    # Compile the assembly language program to a `.o` file.
    args = [c_compiler, '-c', progname]
    if arm64:
        args += ['-arch', 'x86_64']
    if verbose:
        print(f'COMMAND: {" ".join(args)}')
    proc = p.Popen(args, text=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    (stdout_data, stderr_data) = proc.communicate(timeout=timeout)

    # Compiling an assembly language program with a C compiler
    # shouldn't return anything on stderr.
    if stderr_data != '':
        print(stderr_data)
        raise Exception('non-empty stderr data from compiling assembly code')

    # Compile the `runtime.c` program to a `.o` file.
    args = [c_compiler, '-c', 'runtime.c']
    if arm64:
        args += ['-arch', 'x86_64']
    if verbose:
        print(f'COMMAND: {" ".join(args)}')
    proc = p.Popen(args, text=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    (stdout_data, stderr_data) = proc.communicate(timeout=timeout)

    # Compiling 'runtime.c' with a C compiler
    # shouldn't return anything on stderr.
    if stderr_data != '':
        print(stderr_data)
        raise Exception('non-empty stderr data from compiling `runtime.c`')

    # Link the programs to form an executable.
    executable_name = re.sub(r'\.s$', '', basename)
    object_name = re.sub(r'\.s$', '.o', basename)
    args = [c_compiler, object_name, 'runtime.o', '-o', executable_name]
    if arm64:
        args += ['-arch', 'x86_64']
    if verbose:
        print(f'COMMAND: {" ".join(args)}')
    proc = p.Popen(args, text=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    (stdout_data, stderr_data) = proc.communicate(timeout=timeout)

    # Running the executable shouldn't return anything on stderr.
    if stderr_data != '':
        print(stderr_data)
        raise Exception('non-empty stderr data from compiling executable')

    # Remove the object files.
    p.call('/bin/rm -f *.o', shell=True)

    # Run the executable program.
    # NOTE:
    #   If the program requires `read` inputs,
    #   the user must supply them manually when the program is running.
    if verbose:
        print(f'COMMAND: ./{executable_name}')
    proc = p.Popen([f'./{executable_name}'], text=True,
                   stdin=PIPE, stdout=PIPE, stderr=PIPE)
    (stdout_data, stderr_data) = proc.communicate(timeout=timeout)

    # Remove the executable program.
    p.call(f'/bin/rm -f ./{executable_name}', shell=True)

    # Running the executable shouldn't return anything on stderr.
    if stderr_data != '':
        print(stderr_data)
        raise Exception('non-empty stderr data from running executable')

    if stdout_data != '':
        print('OUTPUT (stdout):')
        print('----')
        print(stdout_data)
        print('----')

    ret = proc.returncode
    print(f'OUTPUT (return code): {ret}')


def usage():
    """Print a usage message and exit."""
    progname = os.path.basename(sys.argv[0])
    usagestr = f'usage: {progname} [-arm64] file.s'
    print(usagestr, file=sys.stderr)
    sys.exit(1)


if __name__ == '__main__':
    args = sys.argv[1:]

    if '-arm64' in args:
        compile_arm64 = True
        c_compiler = 'clang'
        args.remove('-arm64')

    if len(args) == 0:
        usage()

    filename = args[0]

    try:
        run_assembly_program(filename, arm64=compile_arm64)
    except Error as e:
        print(f'ERROR: {e}')
