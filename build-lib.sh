#!/bin/bash -xe

source ./build-vars.sh

export LIB_CPPFLAGS="${LIB_CFLAGS} -std=c++14 ${PLATFORM_LIB_CPPFLAGS}"

${CXX} ${LIB_CPPFLAGS} ${LIB_LDFLAGS} -c ${O3}/core/client/ovpncli.cpp  
${CXX} ${LIB_CPPFLAGS} ${LIB_LDFLAGS} -c ${PWD}/o3lib_wrap.cxx
${AR_CMD} libo3lib-${TARGET}.a *.o
