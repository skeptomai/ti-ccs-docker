# Base image which contains global dependencies
FROM ubuntu:20.04 as base
WORKDIR /workdir

# System dependencies
ARG arch=amd64
RUN mkdir /workdir/project && \
	apt update -y && apt upgrade -y && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
        wget \
        git \
        unzip \
        libc6-i386 \
        libusb-0.1-4 \
        libgconf-2-4 \
        libncurses5 \
        libpython2.7 \
        libtinfo5 \
		default-jre-headless && \
    apt-get -y clean && apt-get -y autoremove

RUN mkdir /workdir/cc_studio && \
	cd /workdir/cc_studio && \
	wget --no-check-certificate -q -O ccs11.tar.gz "https://dr-download.ti.com/software-development/ide-configuration-compiler-or-debugger/MD-J1VdearkvK/11.2.0.00007/CCS11.2.0.00007_linux-x64.tar.gz" && \
	tar xzvf ccs11.tar.gz && \
	rm -f ccs11.tar.gz && \
	cd CCS11.2.0.00007_linux-x64 && \
	./ccs_setup_11.2.0.00007.run --mode unattended --prefix /opt/ti --enable-components PF_C28 && \
	rm -rf /workdir/cc_studio && \
	ls -la


# workspace folder for CCS
RUN mkdir /workdir/ccs_workspace

WORKDIR /workdir/project

ENV PATH="/opt/ti/ccs/eclipse:${PATH}"
