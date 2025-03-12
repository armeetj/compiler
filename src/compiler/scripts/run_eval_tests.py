"""
run_eval_tests.py:
    Run evaluation tests on all passes,
    supplying inputs to stdin and reading the program return code.
"""

'''

NOTE: When piping the output to e.g. `tee`, do this first:

$ unbuffer <command> |& tee <command.out>

to turn off buffering.  This requires the `expect` package,
so if it isn't there do:

$ brew install expect

'''

import sys, re, glob, os.path
import subprocess as p
from subprocess import PIPE


verbose          = True
very_verbose     = False  # :)
compile_not_asm  = True
compile_asm      = True
compile_arm64    = False
timeout          = 5  # seconds
compile_program  = './compile'
c_compiler       = 'gcc'
tests_subdir     = './tests'
eval_passes      = ['lfun', 'tc1', 'sh', 'un', 'rf', 'lf', 'tc1b',
                    'ea', 'ug', 'rc', 'ec', 'tc2', 'ru']
reg_options      = ['', 'rcx', 'rbx', 'rcx,rbx']
numpatt          = re.compile(r'^(\d+)')
pause            = False


class Error(Exception):
    """Exception class for compiler output errors."""
    pass


def get_metadata(filename):
    """Get the INPUT and OUTPUT metadata from a .src file."""
    # Get the comment lines at the front of the program.
    lines = []
    with open(filename, 'r') as f:
        for line in f:
            if line.startswith(';'):
                lines.append(line)
            else:
                break
    # Strip comment characters and whitespace from each line.
    clean_lines = []
    for line in lines:
        clean_line = re.sub(r'^[;]+', '', line).strip()
        clean_lines.append(clean_line)
    # Extract the metadata info for INPUT and OUTPUT.
    inputs = None
    outputs = None
    for line in clean_lines:
        if line.startswith('INPUT:'):
            new_line = re.sub(r'^INPUT:', '', line).strip()
            # Split inputs on semicolons.
            inputs = []
            for s in new_line.split(';'):
                inputs.append('\n'.join(s.split()) + '\n')
        elif line.startswith('OUTPUT:'):
            new_line = re.sub(r'^OUTPUT:', '', line).strip()
            # Split outputs on semicolons.
            outputs = list(map(lambda s: s.strip(), new_line.split(';')))
    if inputs:
        if len(inputs) != len(outputs):
            err_msg = "ERROR: input metadata " + \
                      "doesn't have same number of inputs and outputs"
            raise Exception(err_msg)
        metadata = list(zip(inputs, outputs))
    else:
        if len(outputs) != 1:
            raise Exception('can only have one output if no inputs!')
        metadata = [('', outputs[0])]
    return metadata


def run_eval_program(progname, cpass, inputs, output):
    """
    Compile the program `progname` up to compiler pass `cpass`.
    Assume that the program is in the directory `tests_subdir`.
    Run the pass evaluator with standard input supplied by `inputs`.
    Check that the program return value equals `output`.
    """
    if verbose:
        print(f'Running test file ({progname}) up to pass ({cpass}).')
    args = ['./compile', progname, '-pass', cpass, '-eval']
    proc = p.Popen(args, text=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    (stdout_data, stderr_data) = \
        proc.communicate(input=inputs, timeout=timeout)
    ret = proc.returncode

    # These programs shouldn't return anything on stderr.
    if stderr_data != '':
        print(stderr_data)
        raise Exception('non-empty stderr data')

    stdout_data = stdout_data.strip()
    output = output.strip()
    if stdout_data != output:
        err_msg = f'invalid output; expected [{output}] but got [{stdout_data}]'
        raise Error(err_msg)

    if ret != 0:
        raise Exception('ERROR: nonzero return code')


def run_assembly_program(progname, inputs, output, reg_opt, arm64=False):
    """
    Compile the program `progname` to assembly language.
    Also compile `runtime.c` and link to make an executable.
    Run it with the inputs and check the return code;
    it should equal the output.
    Use the registers specified in `reg_opt`;
    if it's `''`, use all registers.
    If `arm64` is `True`, compile on an Apple Arm64 computer
    using Rosetta Stone.
    """
    if verbose:
        if reg_opt == '':
            print('Compiling to assembly language ' + \
                  'and compiling/running the program.')
        else:
            print('Compiling to assembly language ' + \
                  'and compiling/running the program ' + \
                  'using only the register(s): ' + reg_opt)
    basename = os.path.basename(progname)

    if reg_opt == '':
        args = ['./compile', progname]  # no command-line arguments!
    else:
        args = ['./compile', progname, '-regs', reg_opt]
    proc = p.Popen(args, text=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)

    if very_verbose:
        print(f'COMMAND: {" ".join(args)}')

    (stdout_data, stderr_data) = \
        proc.communicate(input=inputs, timeout=timeout)

    # Compiling a program shouldn't return anything on stderr.
    if stderr_data != '':
        print(stderr_data)
        raise Exception('non-empty stderr data')

    # Copy the stdout data to a file ending in `.s`.
    asmname = re.sub(r'\.src$', '.s', basename)
    with open(asmname, 'w') as asmfile:
        print(stdout_data, file=asmfile, end='')

    # Compile the assembly language program to a `.o` file.
    args = [c_compiler, '-c', asmname]
    if arm64:
        args += ['-arch', 'x86_64']
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
    proc = p.Popen(args, text=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    (stdout_data, stderr_data) = proc.communicate(timeout=timeout)

    # Compiling 'runtime.c' with a C compiler
    # shouldn't return anything on stderr.
    if stderr_data != '':
        print(stderr_data)
        raise Exception('non-empty stderr data from compiling `runtime.c`')

    # Link the programs to form an executable.
    executable_name = re.sub(r'\.src$', '', basename)
    object_name = re.sub(r'\.src$', '.o', basename)
    args = [c_compiler, object_name, 'runtime.o', '-o', executable_name]
    if arm64:
        args += ['-arch', 'x86_64']
    proc = p.Popen(args, text=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    (stdout_data, stderr_data) = proc.communicate(timeout=timeout)

    # Running the executable shouldn't return anything on stderr.
    if stderr_data != '':
        print(stderr_data)
        raise Exception('non-empty stderr data from compiling executable')

    # Remove the assembly and object files.
    p.call('/bin/rm -f *.o *.s', shell=True)

    # Run the executable program.
    proc = p.Popen([f'./{executable_name}'], text=True,
                   stdin=PIPE, stdout=PIPE, stderr=PIPE)
    (stdout_data, stderr_data) = proc.communicate(input=inputs, timeout=timeout)

    # Remove the executable program.
    p.call(f'/bin/rm -f ./{executable_name}', shell=True)

    # Running the executable shouldn't return anything on stderr.
    if stderr_data != '':
        print(stderr_data)
        raise Exception('non-empty stderr data from running executable')

    # Running the executable shouldn't return anything on stdout
    # (for this language).
    if stdout_data != '':
        print(stdout_data)
        raise Exception('non-empty stdout data from running executable')

    ret = proc.returncode
    out = int(output)
    if int(output) != ret:
        err_msg = f'invalid output; expected [{out}] but got [{ret}]'
        raise Exception(err_msg)


def run_eval_program_all(progname):
    """
    Call `run_eval_program` with all compiler passes that can be evaluated.
    """
    if verbose:
        print('----')
        print(f'input file: {os.path.basename(progname)}\n')

    progdata = get_metadata(progname)

    for (i, (inputs, output)) in enumerate(progdata):
        if verbose:
            print(f'* input/output data #{i + 1}:\n')
        if compile_not_asm:
            for cpass in eval_passes:
                run_eval_program(progname, cpass, inputs, output)
        if compile_asm:
            for reg_opt in reg_options:
                run_assembly_program(progname, inputs, output,
                                     reg_opt, compile_arm64)
        if verbose:
            print()


def run_eval_files(input_files):
    """Run the compiler for all passes over all input files."""
    for file in input_files:
        if os.path.exists(file):
            run_eval_program_all(file)
        else:
            print(f'The test file: {file} is missing!', file=sys.stderr)
        if pause:
            input('Press <return> to continue...')
            print()


def extract_number(filename):
    """
    Extract the first integer from a filename.
    If there is none, return 0.
    """
    while filename != '':
        m = numpatt.match(filename)
        if m:
            return int(m.group(1))
        filename = filename[1:]
    return 0


def sort_files_numerically(filenames):
    """Sort a list of files based on the first number in the file."""
    new_filenames = filenames[:]
    new_filenames.sort(key=extract_number)
    return new_filenames


def usage():
    """Print a usage message and exit."""
    progname = os.path.basename(sys.argv[0])
    usagestr = f'usage: {progname} [-no-asm] [-arm64] file1 ...'
    print(usagestr, file=sys.stderr)
    sys.exit(1)


if __name__ == '__main__':
    args = sys.argv[1:]

    if '-no-asm' in args:
        compile_not_asm = True
        compile_asm = False
        args.remove('-no-asm')
    if '-only-asm' in args:
        compile_not_asm = False
        compile_asm = True
        args.remove('-only-asm')
    if '-regs' in args:
        regs_index = args.index('-regs')
        regs_string = args[regs_index + 1]
        args.pop(regs_index)
        args.pop(regs_index) # remove regs string too
        reg_options = regs_string.split(';')
        print(f'REGS: {reg_options}')
    if '-arm64' in args:
        compile_arm64 = True
        c_compiler = 'clang'
        args.remove('-arm64')
    if '-pause' in args:
        pause = True

    if len(args) == 0:
        usage()

    try:
        filenames = sort_files_numerically(args)
        run_eval_files(filenames)
    except Error as e:
        print(f'ERROR: {e}')
