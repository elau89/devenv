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
ARG DOCKERHOME=/home/${DOCKERUSER}

RUN useradd -ms /bin/zsh ${DOCKERUSER}
COPY dockerenv ${DOCKERHOME}
RUN chown -R ${DOCKERUSER} ${DOCKERHOME}

USER ${DOCKERUSER}
WORKDIR ${DOCKERHOME}

RUN pip install --user pygments && \
    mkdir -p ${HOME}/.vim/bundle && \
    ./dein_installer.sh ${HOME}/.vim/bundle && \
    TERM=dumb ./oh-my-zsh_installer.sh && \
    cp -fr custom .oh-my-zsh/ && \
    echo "Installing and updating vim plugins..." &&\
    vim --not-a-term -c ":q!" &> /dev/null || true && \
    echo "Vim plugins updated.  Cleaning the installers..." && \
    rm -fr dein_installer.sh oh-my-zsh_installer.sh custom

# Start development environment
CMD ["/bin/tmux","-2u"]
#CMD ["/bin/zsh"]
