#!/bin/bash -x

export TARGET=${TARGET:="linux-clang"}

source core/vars/vars-${TARGET}

export CC=${GCC_CMD}
export CXX=${GPP_CMD}
export O3=${PWD}
export DEP_DIR=${PWD}/deps
export DL=${PWD}/dl
#export PLATFORM=linux
export CGO_ENABLED=1
export AR_CMD=${AR_CMD:="ar rcs"}
export GOARCH=${GOARCH:="amd64"}
export CLINKDIR=${CLINKDIR:="."}
export BUILD_LIBS=${BUILD_LIBS:="/build-libs"}
export BUILD_BINS=${BUILD_BINS:="/build"}
#export CGO_PLATFORM_LDFLAGS=${}

export ASIO_FLAGS="-DUSE_ASIO \
		-DASIO_STANDALONE \
		-DASIO_NO_DEPRECATED \
		-DASIO_HAS_CLANG_LIBCXX \
		-DASIO_DISABLE_SERIAL_PORT \
        -DASIO_DISABLE_STD_STRING_VIEW"
		#-DASIO_DISABLE_STD_SYSTEM_ERROR"
		#
        #-DASIO_DISABLE_EPOLL" 
		#-DASIO_HAS_STD_STRING_VIEW
        #    -DASIO_DISABLE_SIGNAL \
        # -DASIO_DISABLE_THREADS \
        # -DASIO_HAS_EVENTFD \

vis2='' #'-DSWIGEXPORT=__attribute__((visibility("default")))'
export LIB_CFLAGS="-I${PWD}/core \
		-I${PWD}/core/client \
		${ASIO_FLAGS} \
		-DUSE_MBEDTLS \
		-I${DEP_DIR}/mbedtls/mbedtls-${PLATFORM}/include \
		${PLATFORM_FLAGS} \
		-DHAVE_LZ4 \
		-DOPENVPN_ALLOW_INSECURE_CERTPROFILE \
        -DOPENVPN_PACKAGE_ID=net_openvpn_openvpn \
        -fvisibility=hidden \
		-I${DEP_DIR}/asio/asio/include \
    	-I${DEP_DIR}/lz4/lz4-${PLATFORM}/include \
		-fPIC -v -frtti -fexceptions $vis2 -pthread"

	#	-fomit-frame-pointer \ not supported on ios    
		#-Wno-unused-local-typedefs -Wno-unused-variable -Wno-shift-count-overflow -fPIC -v
		
    	#-lmbedtls  
    #ssl_libdir="-L${DEP_DIR}/mbedtls/mbedtls-${PLATFORM}/library"
export LIB_CPPFLAGS="${LIB_CFLAGS}" # -std=c++14" # -std=c11 # -stdlib=libc++
export LIB_LDFLAGS="${LIB_CFLAGS} \
	-L${DEP_DIR}/lz4/lz4-${PLATFORM}/lib \
    -llz4 \
	-lmbedtls \
    -L${DEP_DIR}/mbedtls/mbedtls-${PLATFORM}/library \
	-frtti"
    # -static -frtti #,-soname,libovpncli.so


export CGO_LDFLAGS="-lo3lib-${TARGET} -L${PWD} -L${BUILD_LIBS} \
	-lmbedtls -L${DEP_DIR}/mbedtls/mbedtls-${PLATFORM}/library \
	-L${DEP_DIR}/lz4/lz4-${PLATFORM}/lib -L${CLINKDIR} \
	-llz4 -frtti -static-libstdc++ ${CGO_PLATFORM_LDFLAGS} -std=c++14 -lstdc++" # -L/usr/lib/x86_64-linux-gnu/ -lstdc++"

export CGO_CFLAGS=${LIB_CFLAGS}
export CGO_CPPFLAGS="${LIB_CPPFLAGS}"
export CGO_CXXFLAGS="${LIB_CPPFLAGS} -std=c++14 ${PLATFORM_LIB_CPPFLAGS}"

#export CXXFLAGS="-std=c++14"
