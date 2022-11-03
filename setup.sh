#!/bin/bash

# This script should be source'd by the students to set up
# their accounts.  Use this command:
#
# source /home/energy/stly/batman-summerschool/setup.sh
#
# Script shamelessly copied and modified from the CAMD summerschool '18 version

if [[ "`uname`" != "Linux" ]]; then
    echo "ERROR: Should be run on a Linux machine, not `uname`"
    exit 1
fi

echo
echo
echo "SETTING UP NIFLHEIM ACCOUNT FOR USER" $USER
echo


# Set up .bashrc
cd
BRCSCRIPT=/home/energy/stly/batman-summerschool/activate.sh
grep -q "source $BRCSCRIPT" .bashrc
if [[ $? -eq 0 ]]; then
    echo "Your .bashrc file is already set up.  Good."
else
    echo "Setting up your .bashrc file."
    echo "" >> .bashrc
    echo "source $BRCSCRIPT" >> .bashrc
    echo "" >> .bashrc
    source $BRCSCRIPT
fi

# Make a folder for Notebook files.
FOLD=batman19
if [[ -d $FOLD ]]; then
    echo "The folder $FOLD (for your Jupyter Notebooks) already exists.  Good."
else
    echo "Creating folder name '$FOLD' for your Jupyter Notebooks."
    mkdir $FOLD
fi

# HERE WE NEED TO COPY THE NOTEBOOKS

SOURCEDIR=/home/energy/stly/batman-summerschool/notebooks

echo "Copying notebook files into $FOLD (if missing)."
# Order is important, the FIRST matching pattern counts.
rsync -vrltbm -u --ignore-existing --include="*/" --include="*.traj" --exclude="*.master.db" --include="*.db" --exclude="*.master.ipynb" --include="*.ipynb" --include="*/*.png" --include="*.xyz" --include="*.py" $SOURCEDIR/. $FOLD/.

# Set up jupyter notebook config

echo
if [[ -d .jupyter ]]; then
    echo "Jupyter Notebook configuration folder (.jupyter) found."
else
    echo "Creating Jupyter Notebook default configuration files."
    jupyter notebook --generate-config
fi

echo "Enabling Jupyter Notebook extensions."
#jupyter nbextension enable nglview --py 
jupyter nbextension enable widgetsnbextension --py


# Set up a Jupyter Notebook password.
PSWDFILE=.jupyter/jupyter_notebook_config.json
if [[ -f $PSWDFILE ]]; then
    grep -q password $PSWDFILE
    if [[ $? -eq 0 ]]; then
	NEEDPSWD=0
    else
	NEEDPSWD=1
    fi
else
    NEEDPSWD=1
fi
if [[ $NEEDPSWD -ne 0 ]]; then
    echo
    echo
    echo "IMPORTANT: You should now set a password you use to access your"
    echo "    Jupyter Notebooks.  You should probably NOT use your usual"
    echo "    DTU password (never give it to random programs asking for it!)"
    echo "    Choose a new password."
    echo
    jupyter notebook password
    echo
    
    # Test if it worked
    grep -q password $PSWDFILE
    if [[ $? -eq 0 ]]; then
	echo "Your password was set.  To change it later, run this command:"
	echo "    jupyter notebook password"
    else
	echo "ERROR: Setting the password FAILED"
	echo "    Please run this script again."
	exit 1
    fi
    echo
else
    echo
    echo "You already have a Jupyter Notebook password.  Good."
    echo "If you need to change it, run the command"
    echo "    jupyter notebook password"
    echo
fi

echo "You are now all set!"
echo "The notebook files are in the folder $FOLD"
echo
echo "To start a notebook do: notebook"
echo
echo "Then pay notice to the port the server is using. Example:"
echo "http://surt.fysik.dtu.dk:8888/ here 8888 is the port."
echo "You will need this for connecting to the notebook"
echo
echo "Connecting to the notebook:"
echo
echo "Linux/Mac:"
echo "Open a new terminal window and put in the command:"
echo "ssh -N -L 8080:surt.fysik.dtu.dk:<port> $USER@demon.fysik.dtu.dk"
echo "(Inserting the correct <port> number)"
echo
echo "Windows:"
echo "In MobaXterm click the \"Tunneling\" button and then \"New SSH Tunnel\""
echo "Type 8080 at My computer"
echo "As SSH server put: demon.fysik.dtu.dk and $USER"
echo "As the Remote server put: surt.fysik.dtu.dk and the correct port number"
echo
echo "Finally (Linux/Mac/Windows):"
echo "Open a browser window and navigate to: http://localhost:8080"
echo
