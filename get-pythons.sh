#!/bin/sh

set -ex

cleanup_after_install () {
    find /usr/local -depth -type d -a  -name test -o -name tests -o  -type f -a -name '*.pyc' -o -name '*.pyo' -exec rm -rf '{}' +
    rm -rf /usr/src/python
}


get_install () {
    PY_VERSION=$1
    cd /tmp
    wget https://www.python.org/ftp/python/$PY_VERSION/Python-$PY_VERSION.tgz
    tar xzf Python-$PY_VERSION.tgz
    cd /tmp/Python-$PY_VERSION
    ./configure && make && make altinstall
    cd /tmp
    rm Python-$PY_VERSION.tgz && rm -r Python-$PY_VERSION
}


# First, get and install Python 3.7 from the latest git install.
cd  /tmp/
wget https://github.com/python/cpython/archive/master.zip
unzip master.zip
cd /tmp/cpython-master
./configure && make && make altinstall
# Remove the git clone.
rm -r /tmp/cpython-master && rm /tmp/master.zip

# Install Python 3.4, 3.5, 3.6, 2.7
get_install $PYTHON_34_VER
get_install $PYTHON_35_VER
get_install $PYTHON_36_VER

# After we have installed all the things, we cleanup tests and unused files
# like .pyc and .pyo
cleanup_after_install
