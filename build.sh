#!/bin/sh

gambit_build_script='../gambit/misc/build-gambit-iOS'
$gambit_build_script --no-update || exit $?

rm -rf include lib
mkdir -p include lib
(cd gambit-iOS/current; find lib -name 'lib*.a' |cpio -p ../..)
(cd gambit-iOS/current; find include -name '*.h' |cpio -p ../..)

gambit_source_dir=`sed -n 's/^gambit_dist_if_downloaded="\(.*\)"/\1/p' $gambit_build_script`
compiler_dir="`pwd`/compiler"

rm -rf "$gambit_source_dir"
tar xzf "$gambit_source_dir.tgz"
cd "$gambit_source_dir"

./configure --prefix="$compiler_dir"
make clean
make -j 2
make install

cd ..
