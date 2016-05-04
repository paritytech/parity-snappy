FROM ubuntu:14.04
WORKDIR /build
# install tools and dependencies
RUN apt-get -y update && \
	apt-get install -y --force-yes --no-install-recommends \
	curl git make g++ gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
	libc6-arm64-cross libc6-dev-arm64-cross wget file ca-certificates \
	binutils-aarch64-linux-gnu \
	&& \
    apt-get clean

# install multirust
RUN curl -sf https://raw.githubusercontent.com/brson/multirust/master/blastoff.sh | sh -s -- --yes
ENV RUST_TARGETS="aarch64-unknown-linux-gnu"
# multirust override beta
#RUN multirust override beta

# multirust add arm--linux-gnuabhf toolchain
RUN multirust add-target stable aarch64-unknown-linux-gnu

# show backtraces
ENV RUST_BACKTRACE 1
# set compilers
ENV CXX aarch64-linux-gnu-g++
ENV CC aarch64-linux-gnu-gcc 
ENV ARCH arm
ENV CROSS_COMPILE aarch64-unknown-linux-gnu
ENV TARGET aarch64-unknown-linux-gnu
# build parity
RUN git clone https://github.com/ethcore/parity && \
	cd parity && \
	git checkout master && \
	wget https://github.com/thkaw/mio/archive/v0.5.x.tar.gz && \
	tar -xf v0.5.x.tar.gz && \
	rm -rf v0.5.x.tar.gz && \
	mkdir -p .cargo && \
  	echo 'paths = ["mio-0.5.x"]\n\
	[target.aarch64-unknown-linux-gnu]\n\
	linker = "aarch64-linux-gnu-gcc"\n'\
	>>.cargo/config && \
	cat .cargo/config && \
	find . -name '*.toml' -type f -exec sed -i -e 's/nix    = \"0.4.2\"/nix    = \"0.5\"/g' {} \;&& \
	cargo build --target aarch64-unknown-linux-gnu --release --verbose && \
	ls /build/parity/target/aarch64-unknown-linux-gnu/release/parity &&	\
	file /build/parity/target/aarch64-unknown-linux-gnu/release/parity && \
	/usr/bin/aarch64-linux-gnu-strip /build/parity/target/aarch64-unknown-linux-gnu/release/parity
RUN file /build/parity/target/aarch64-unknown-linux-gnu/release/parity
