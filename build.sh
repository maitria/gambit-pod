#!/bin/sh

DIRS='include lib'

../gambit/misc/build-gambit-iOS || exit $?

rm -rf include lib
mkdir -p include lib
(cd gambit-iOS/current; find lib -name 'lib*.a' |cpio -p ../..)
(cd gambit-iOS/current; find include -name '*.h' |cpio -p ../..)
