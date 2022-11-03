## CLEASE hands-on session

We will use Python and Jupyter notebook for this hands-on session. CLEASE is written in Python and C++. If you are using Windows, it is much preferred to use conda for package management and installation. So, if you don't have Python/conda in your computer, please go ahead and install miniconda from ![this link][https://docs.conda.io/en/latest/miniconda.html].

Now, open `Terminal` (Mac or Linux) or `Anaconda Prompt` (Windows) app and type the following lines. 

>>> conda create --name clease python=3.10
>>> conda activate clease
>>> conda install clease clease-gui

The first line creates a virtual environment named `clease` using Python version 3.10. The virtual environment is activated using the command on the second line. The two necessary packages, `clease` and `clease-gui` (and their dependencies) are installed usign the install command. Since installing `clease-gui` automatically installs Jupyter package, you can open Jupyter notebook by typing the following command. Make sure that you are in the folder that contains `part1_clease_script.ipynb` and `part2_clease_gui.ipynb`.
`
>>> jupyter notebook
