"""
compare.py:
    Compare compiler outputs for a particular input file and pass.
"""

import sys, re, os, random
import subprocess as p
from subprocess import PIPE
from pathlib import Path


passes  = ['lwhile', 'sh', 'un', 'ug', 'rc', 'ec', 'tc2', 'ru',
           'si', 'ul', 'bi', 'ar', 'rj', 'pi', 'pc', 'pa']
inpatt  = re.compile(r'^reference/(\w+).(\w+)((,.*)?)$')
numpatt = re.compile(r'^(\d+)')
timeout = 5  # seconds
pause   = False
diff    = False
nrandom = -1


def fatal_error(msg):
    sys.stdout.flush()
    print(f'ERROR: {msg}', file=sys.stderr)
    sys.stderr.flush()
    sys.exit(1)


class Error(Exception):
    """Exception class for compiler output errors."""
    pass


def replace_tabs(s, tabstop=8):
    """Replace tabs by spaces, respecting tab stops."""
    result = ''
    count = 0
    for c in s:
        if c == '\t':
            result += ' '
            count += 1
            while count % tabstop != 0:
                result += ' '
                count += 1
        else:
            result += c
            count += 1
    return result


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


def compare_index(filename):
    """Compute a comparison index for a filename."""
    n = extract_number(filename)
    match = inpatt.match(filename)
    assert match is not None
    root = match.group(1)
    inpass = match.group(2)
    regs = match.group(3)
    if regs != '':
        regs = regs[1:]
    if inpass in passes:
        pass_index = passes.index(inpass)
    else:
        pass_index = 1000
    return (n, pass_index, regs)


def order_filenames(filenames):
    """
    Order a list of filenames based on two criteria:
    - based on the file extension in the order of the passes
    - numerically based on the test number
    The test "number" is the first integer found in the filename.
    The pass is the extension (whatever follows the last '.').
    """
    new_filenames = filenames[:]
    new_filenames.sort(key=compare_index)
    return new_filenames


def random_filenames(filenames, n):
    """
    Pick n random filenames from the list of filenames given.
    Keep them in their original order.
    Note that this only makes sense
    if all the filenames have the same extension.
    """
    if n >= len(filenames):
        return filenames
    
    new_filenames = filenames[:]
    random.shuffle(new_filenames)
    new_filenames = new_filenames[:n]
    return order_filenames(new_filenames)


def diff_filename(infilename):
    """
    Compare the compiler output for a file `infilename`
    to the corresponding output file for that pass
    located in the `reference` directory.
    The pass is inferred from the filename extension.
    Do the comparison by invoking the `diff` program.
    """

    match = inpatt.match(infilename)
    if not match:
        fatal_error(f'invalid input filename: {infilename}')

    root = match.group(1)
    inpass = match.group(2)
    regs = match.group(3)
    if regs != '':
        regs = regs[1:]

    if inpass not in passes or inpass == 'pa':
        fatal_error(f'invalid input pass: {inpass}')

    inpass_i = passes.index(inpass)
    outpass = passes[inpass_i + 1]

    if regs == '':
        args = ['./compile', infilename, '-pass', outpass, '-only',
                '-no-fix-label']
    else:
        args = ['./compile', infilename, '-pass', outpass, '-only',
                '-no-fix-label', '-regs', regs]

    proc = p.Popen(args, text=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    (stdout_data, stderr_data) = proc.communicate(timeout=timeout)
    ret = proc.returncode

    # Compiling the source file shouldn't return anything on stderr.
    if stderr_data != '':
        print(stderr_data)
        raise Error('compile: non-empty stderr data')

    if ret != 0:
        print(f'compilation of {infilename} failed!')

    # Copy the output to a file.
    if regs == '':
        outfilename = root + '.' + outpass
    else:
        outfilename = root + '.' + outpass + ',' + regs

    with open(outfilename, 'w') as outfile:
        print(stdout_data, file=outfile, end='')

    reffilename = 'reference/' + outfilename

    # Call the `diff` program.
    args = ['diff', '--strip-trailing-cr', outfilename, reffilename]
    proc = p.Popen(args, text=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    (stdout_data, stderr_data) = proc.communicate(timeout=timeout)
    ret = proc.returncode

    if stderr_data != '':
        print(stderr_data)
        raise Error('diff: non-empty stderr data')

    if ret == 0:
        print("OK")
    else:
        print("DIFFERENT")
        print('----')
        print(stdout_data, end='')
        print('----')

    # Remove the compiled file.
    os.remove(outfilename)


def compare_filename(infilename):
    """
    Compare the compiler output for a file `infilename`
    to the corresponding output file for that pass
    located in the `reference` directory.
    The pass is inferred from the filename extension.
    Do the comparison visually by printing the two files side-by-side.
    """

    match = inpatt.match(infilename)
    if not match:
        fatal_error(f'invalid input filename: {infilename}')

    root = match.group(1)
    inpass = match.group(2)
    regs = match.group(3)
    if regs != '':
        regs = regs[1:]

    if inpass not in passes or inpass == 'pa':
        fatal_error(f'invalid input pass: {inpass}')

    inpass_i = passes.index(inpass)
    outpass = passes[inpass_i + 1]

    if regs == '':
        args = ['./compile', infilename, '-pass', outpass, '-only',
                '-no-fix-label']
    else:
        args = ['./compile', infilename, '-pass', outpass, '-only',
                '-no-fix-label', '-regs', regs]

    proc = p.Popen(args, text=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    (stdout_data, stderr_data) = proc.communicate(timeout=timeout)
    ret = proc.returncode

    # Compiling the source file shouldn't return anything on stderr.
    if stderr_data != '':
        print(stderr_data)
        raise Error('compile: non-empty stderr data')

    if ret != 0:
        print(f'compilation of {infilename} failed!')

    # Generate the student output lines.
    outlines = []
    line = '# Student version.'
    outlines.append(line)
    lines = stdout_data.split('\n')[:-1]
    for line in lines:
        outlines.append(line)
    out_max_len = max(map(len, outlines))

    # Generate the reference output lines.
    reflines = []
    line = '# Reference version.'
    reflines.append(line)
    if regs == '':
        outfilename = root + '.' + outpass
    else:
        outfilename = root + '.' + outpass + ',' + regs
    with open('reference/' + outfilename, 'r') as inref:
        for line in inref:
            reflines.append(line[:-1])
    ref_max_len = max(map(len, reflines))

    pad = 10  # characters

    # Display output side-by-side.
    while outlines or reflines:
        # Get the next lines.
        if outlines:
            outline = outlines.pop(0)
        else:
            outline = ''
        if reflines:
            refline = reflines.pop(0)
        else:
            refline = ''

        # Pad the sublines to the max lengths.
        outdiff = out_max_len - len(outline)
        assert outdiff >= 0
        outline += ' ' * outdiff

        refdiff = ref_max_len - len(refline)
        assert refdiff >= 0
        refline += ' ' * refdiff

        line = outline + (' ' * pad) + refline
        print(line)


def get_output_filename(infilename):
    """
    Return the output filename corresponding to an input filename.
    """
    match = inpatt.match(infilename)
    if not match:
        fatal_error(f'invalid input filename: {infilename}')

    root = match.group(1)
    inpass = match.group(2)
    regs = match.group(3)
    if regs != '':
        regs = regs[1:]

    if inpass not in passes or inpass == 'pa':
        fatal_error(f'invalid input pass: {inpass}')

    inpass_i = passes.index(inpass)
    outpass = passes[inpass_i + 1]
    return 'reference/' + root + '.' + outpass


if __name__ == '__main__':
    usagestr = 'usage: python compare.py ' + \
               '[-pause] [-diff] [-random n] filename [filename ...]'

    args = sys.argv[1:]

    if '-pause' in args:
        args.remove('-pause')
        pause = True

    if '-diff' in args:
        args.remove('-diff')
        diff = True

    if '-random' in args:
        i = args.index('-random')
        args.remove('-random')
        try:
            nrandom = int(args.pop(i))
        except ValueError:
            print('ERROR: `-random` argument must be a positive integer',
                  file=sys.stderr)
            sys.exit(1)
        except IndexError:
            print('ERROR: no argument for `-random` option',
                  file=sys.stderr)
            sys.exit(1)
        if nrandom <= 0:
            print('ERROR: `-random` argument must be a positive integer',
                  file=sys.stderr)
            sys.exit(1)

    filenames = args
    # Skip '.pa' pass; you can't compile it.
    orig_filenames = filenames[:]
    filenames = list(filter(lambda s: not s.endswith('.pa'), filenames))
    filenames = list(filter(lambda s: '.pa,' not in s, filenames))
    filenames = order_filenames(filenames)
    if nrandom > 0:
        filenames = random_filenames(filenames, nrandom)

    if len(filenames) < 1:
        print(usagestr, file=sys.stderr)
        sys.exit(1)

    if diff:
        for infilename in filenames:
            if not os.path.isfile(infilename):
                print(f'ERROR: input file {infilename} does not exist!')
                continue
            print(infilename, ': ', end='')
            try:
                diff_filename(infilename)
            except Error as e:
                print()
                print(f'==================================')
                print() 
                print(f'{infilename}: ERROR: {e}')
                print()
                print(f'==================================')
                print()
    else:
        for infilename in filenames:
            print('--------------')
            print('input: ' + infilename)
            print('output: ' + get_output_filename(infilename))
            print()
            if not os.path.isfile(infilename):
                print(f'ERROR: input file {infilename} does not exist!')
                continue
            try:
                compare_filename(infilename)
            except Error as e:
                print()
                print(f'==================================')
                print() 
                print(f'{infilename}: ERROR: {e}')
                print()
                print(f'==================================')
                print()
            print()
            if pause:
                input(';; press <return> to continue ...\n')

    if pause:
        print('DONE!')

