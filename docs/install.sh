#!/bin/sh
VERSION="0.7.3"
ARCH=$(uname -m)
URL="https://github.com/vchain-us/vcn/releases/download/v$VERSION/vcn-v$VERSION-$ARCH-10.6-amd64"

check_curl(){
	which curl &> /dev/null 
	if [[ $? -ne 0 ]] ; then
			echo '"curl" binary not found, please install and retry'
			exit 1
	fi
}

check_os() {
	if [ "$(uname)" = "Linux" ] ; then
		PKG="linux"
		echo "Running on Linux"

	elif [ "$(uname)" = "Darwin" ] ; then
		PKG="darwin"
		echo "Running on Apple"
	else
		echo "Unknown operating system"
		echo "Please select your operating system:"
		echo "	     linux"
		echo "	     MacOS"
		read PKG
	fi
}

install() {
  TMPDIR=$(mktemp -d) && cd $TMPDIR
	curl --connect-timeout 100 -L $URL >> vcn
	echo "Done. You can run now: $ vcn"

	if [ "$PKG" = "linux" ] ; then
	  sudo cp $TMPDIR/vcn /usr/bin && sudo chmod +x /usr/bin/vcn
	fi

	if [ "$PKG" = "darwin" ] ; then
	  sudo cp $TMPDIR/vcn /usr/local/bin && sudo chmod +x /usr/local/bin/vcn
	fi
}

cleanup() {
  rm $TMPDIR/*
  rmdir $TMPDIR
}

check_curl
echo  "";
echo "CodeNotary vcn CLI - Install"
echo "----------------------------"
echo "Please wait. We are downloading and installing the cli app for you..." 
check_os
install
cleanup