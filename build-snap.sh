!#bin/sh
echo "get latest ARM build"
wget https://github.com/ethcore/parity-snappy/releases/download/v1.1.0-dev-unstable.1/parity-arm-v1.1.0-dev-unstable.1.tar.gz
tar -xvf parity-arm-v1.1.0-dev-unstable.1.tar.gz parity-arm
echo "check file"
file parity-arm
echo "copy parity ARM binary to /snap/bin/arm-linux-gnueabihf/geth"
mv parity-arm ./snap/bin/arm-linux-gnueabihf/parity
rm -rf parity*
echo "clean current directory"
cd snap
echo "build parity snappy"
snappy build
echo "build complete"
