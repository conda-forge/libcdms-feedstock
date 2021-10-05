export CFLAGS="-Wall -g -pipe -O2  -fPIC ${CFLAGS}"
if [[ "$target_platform" != "linux-aarch64" ]]; then
  # probably not necessary anywhere, but makes aarch64 unhappy for sure
  export CFLAGS="-m64 ${CFLAGS}"
fi
export CXXLAGS="${CFLAGS} ${CXXLAGS}"
export CPPFLAGS="-I${PREFIX}/include ${CPPPFLAGS}"
export LDFLAGS="-L${PREFIX}/lib ${LDFLAGS}"
export LDSHARED="$CC -shared -pthread" ;

./configure \
    --enable-dap= \
    --enable-drs \
    --with-drslib=${PREFIX}/lib \
    --with-drsinc=${PREFIX}/include \
    --with-drsincf=${PREFIX}/include \
    --enable-hdf=no \
    --enable-pp=yes \
    --enable-ql=no \
    --cache-file=/dev/null \
    --with-nclib=${PREFIX}/lib \
    --with-ncinc=${PREFIX}/include \
    --with-daplib=${PREFIX}/lib \
    --with-dapinc=${PREFIX}/include \
    --with-hdfinc=${PREFIX}/include \
    --with-hdflib=${PREFIX}/lib \
    --with-hdf5lib=${PREFIX}/lib \
    --with-pnglib=${PREFIX}/lib \
    --with-grib2lib=${PREFIX}/lib \
    --with-jasperlib=${PREFIX}/lib \
    --with-grib2inc=${PREFIX}/include \
    --enable-grib2 \
    --prefix=${PREFIX} || (cat config.log && exit 1)

make 
make libinstall
make bininstall
# no make check or make test
