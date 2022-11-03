#!/usr/bin/env python
"""GPAW-wrapper for sbatch."""

import argparse
import subprocess

description = 'Submit a GPAW Python script via sbatch.'

cores = 16


def main():
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('-t', '--time', type=int, default=1,
                        help='Max running time in hours.')
    parser.add_argument('-p', '--partition', type=str, default='xeon16',
                        choices=['xeon8', 'xeon16'],
                        help='Type of processor, xeon16 (default) or xeon8.')
    parser.add_argument('-z', '--dry-run', action='store_true',
                        help='Don\'t actually submit script.')
    parser.add_argument('script', help='Python script')
    parser.add_argument('argument', nargs='*',
                        help='Command-line argument for Python script.')
    args = parser.parse_args()
    arguments = ' '.join(args.argument)
    cmd = f'gpaw-python {args.script} {arguments}'
    lines = [
        '#!/bin/bash -l',
        '###SBATCH -N 1',
        f'#SBATCH -n {cores}',
        f'#SBATCH --time {args.time}:00:00',
        f'#SBATCH --partition {args.partition}',
        f'#SBATCH --job-name {args.script}',
        'cd $SLURM_SUBMIT_DIR',
        f'OMP_NUM_THREADS=1 mpiexec {cmd}']
    script = '\n'.join(lines) + '\n'
    if args.dry_run:
        print(script)
    else:
        p = subprocess.Popen(['sbatch'], stdin=subprocess.PIPE)
        p.communicate(script.encode())


if __name__ == '__main__':
    main()
