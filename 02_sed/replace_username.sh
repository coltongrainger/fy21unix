#! /bin/bash
#
# replace_username.sh
# 2020-09-14
# unix.stackexchange.com/questions/78625

sed -E "s/(<username>.+)name(.+<\/username>)/\1something\2/" $1
