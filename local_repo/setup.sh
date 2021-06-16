#!/bin/bash

cd ivy
python2.7 build_submodules.py
mkdir -p "/home/user/python/lib/python2.7/site-packages"
export PYTHONPATH="/home/user/python/lib/python2.7/site-packages"
# need to install pyparsing manually because otherwise wrong version found
pip install pyparsing
python2.7 setup.py develop --prefix="/home/user/python/"
export PATH=$PATH:"/home/user/python/bin/"
