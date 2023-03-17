# Base image which contains global dependencies
FROM ubuntu:20.04 as base
WORKDIR /workdir

# ARG USER_NAME=jenkins
# ARG USER_ID=1000
# ARG GROUP_ID=1000

# # Create a new user with the desired UID and GID
# RUN groupadd -g ${GROUP_ID} ${USER_NAME} && \
#     useradd -u ${USER_ID} -g ${GROUP_ID} -ms /bin/bash ${USER_NAME}


# System dependencies
ARG arch=amd64
RUN apt update -y && apt upgrade -y && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
        wget \
        unzip \
        libc6-i386 \
        libusb-0.1-4 \
        libgconf-2-4 \
        libncurses5 \
        libpython2.7 \
        libtinfo5 && \
    apt -y clean && apt -y autoremove && rm -rf /var/lib/apt/lists/*

RUN mkdir /workdir/cc_studio && \
	cd /workdir/cc_studio && \
	wget --no-check-certificate -q -O ccs11.tar.gz "https://dr-download.ti.com/software-development/ide-configuration-compiler-or-debugger/MD-J1VdearkvK/11.2.0.00007/CCS11.2.0.00007_linux-x64.tar.gz" && \
	tar xzvf ccs11.tar.gz && \
	cd CCS11.2.0.00007_linux-x64 && \
	./ccs_setup_11.2.0.00007.run --mode unattended --prefix /opt/ti --enable-components PF_C28 && \
	cd /workdir && \
	rm -rf /workdir/cc_studio


# workspace folder for cube ide
RUN mkdir /workdir/project && mkdir /workdir/ccs_workspace
#     chown -R ${USER_NAME}:${USER_NAME} /workdir/project
# USER ${USER_NAME}:${USER_NAME}

WORKDIR /workdir/project

ENV PATH="/opt/ti/ccs/eclipse:${PATH}"
