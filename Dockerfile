FROM fedora:latest

# Install dependency packages
RUN ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime && \
    dnf upgrade -y && \
    dnf install -y --best --allowerasing \
        gcc \
        gcc-c++ \
        git \
        htop \
        nc \
        nmap \
        procps-ng \
        python \
        python-pip \
        the_silver_searcher \
        telnet \
        tmux \
        util-linux-user \
        vim \
        zsh && \
    dnf clean all

# Prepare user account
ARG DOCKERUSER=dockeruser
ENV DOCKERHOME=/home/${DOCKERUSER}

RUN useradd -Ms /bin/zsh ${DOCKERUSER}

USER ${DOCKERUSER}
WORKDIR ${DOCKERHOME}

# Start development environment
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["${DOCKERHOME}/installer.sh && tmux -2u"]
