#!/bin/bash
file=$1
set -x

ghdl -a --ieee=synopsys -fexplicit $file.vhd