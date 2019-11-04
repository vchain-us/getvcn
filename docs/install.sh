#!/bin/sh
VERSION="0.7.3"
ARCH=$(uname)
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
	elif [ "$(uname)" = "Darwin" ] ; then
		PKG="darwin"
	else
		echo "Unknown operating system."
		exit 1
	fi
}

install() {
  TMPDIR=$(mktemp -d) && cd $TMPDIR
	curl --connect-timeout 100 -L $URL >> vcn

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
echo "🎉 Done. You can run now: $ vcn"