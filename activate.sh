#!/bin/sh

module purge

# GPAW and ASE
# ASE
module load GPAW/1.5.2-intel-2018b-Python-3.6.6
# Export the clease ase to pythonpath
ASE=/home/niflheim/jchang/pkgs/ase
export PATH=$ASE/bin:$PATH
export PYTHONPATH=$ASE:$PYTHONPATH

# AMP
# Export amp to pythonpath
export PYTHONPATH=/home/energy/aegm/amp_surt:$PYTHONPATH

# Jupyter
module load jupyter/1.0.0-intel-2018b-Python-3.6.6

alias l="ls -ltr"
alias p=python
export PATH=/home/energy/stly/batman-summerschool:$PATH

# Numba for clease
export PYTHONPATH=/home/energy/stly/batman-libs/lib/python3.6/site-packages:$PYTHONPATH

unset MPLBACKEND
