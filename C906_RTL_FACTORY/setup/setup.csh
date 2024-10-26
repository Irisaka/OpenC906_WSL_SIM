#!/bin/bash

set pattern = "\/setup"`echo '$'`
#setenv CODE_BASE_PATH `pwd | perl -pe "s/$pattern//"`
export CODE_BASE_PATH=`pwd | perl -pe "s/$pattern//"`
echo "Root of code base has been specified as:\n    $CODE_BASE_PATH"




