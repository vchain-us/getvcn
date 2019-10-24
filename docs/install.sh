#!/bin/sh
URL=https://github.com/vchain-us/vcn/releases/download/v0.7.2/vcn-v0.7.2-darwin-10.6-amd64

echo "Please wait. We are downloading and installing CodeNotary vcn for you..." 
cd ~
curl --connect-timeout 100 -L $URL >> vcn
chmod 777 vcn
mv vcn /usr/local/bin/
echo "Done. You can run now: $ vcn"
