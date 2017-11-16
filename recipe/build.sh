export CFLAGS="-Wall -g -m64 -pipe -O2  -fPIC ${CFLAGS}"
export CXXLAGS="${CFLAGS} ${CXXLAGS}"
export CPPFLAGS="-I${PREFIX}/include ${CPPPFLAGS}"
export LDFLAGS="-L${PREFIX}/lib ${LDFLAGS}"

if [ $(uname) == "Linux" ];then
    if [ ! -f ${PREFIX}/lib/libgfortran.so ]; then
        ln -s ${PREFIX}/lib/libgfortran.so.3.0.0 ${PREFIX}/lib/libgfortran.so
    fi
fi

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
    --with-daplib=/lib \
    --with-dapinc=/include \
    --with-hdfinc=./include \
    --with-hdflib=./lib \
    --with-hdf5lib=${PREFIX}/lib \
    --with-pnglib=/usr/X11/lib \
    --with-grib2lib=${PREFIX}/lib \
    --with-jasperlib=${PREFIX}/lib \
    --with-grib2inc=${PREFIX}/include \
    --enable-grib2 \
    --prefix=${PREFIX}
make 
make libinstall
make bininstall
# no make check or make test
