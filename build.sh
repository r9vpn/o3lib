#!/bin/bash -xe

source ./build-vars.sh


case ${TARGET} in
	linux-clang)
		#export CGO_LDFLAGS="${CGO_LDFLAGS} -static"
		go build -o /build/o3cli cli/*.go
		
		;;
	osx)
		#export CGO_LDFLAGS="${CGO_LDFLAGS} -static"
		export PLATFORM_ARCH_FLAGS="-arch x86_64"
		source ./build-vars.sh
		#go build -o ./build/o3cli cli/*.go
		gomobile bind -target macos/amd64 -v -x github.com/sysr9/o3lib/o3bridge
		
		;;
	ios)
		export PLATFORM_ARCH_FLAGS="-arch arm64"
		source ./build-vars.sh
		gomobile bind -target ios -prefix o3ios -x -v ./o3bridge 
		
		;;
	*)
		gomobile bind -v -x -o ${PLATFORM}.aar \
    		-target=android/${GOARCH} ./o3bridge
		#sudo mv ${PLATFORM}.aar /build/
		;;
esac
# 
# exit 0
    #  -ldflags "${CGO_LDFLAGS}" -gcflags "${CGO_CFLAGS}" \
    # ./

# gobind -lang java,go -outdir ./java ./
# GOOS=android GOARCH=386 go build -x -o build/o3cli.so -buildmode=c-shared ./
