# Docker commands
DOCKERBIN ?= docker
DOCKERCMD ?=

# Build-time variables
DOCKERFILE ?= Dockerfile
DOCKERPATH ?= .
DOCKERREPO ?= devenv
DOCKERTAG ?= latest

DOCKERUSER ?= dockeruser
DOCKERMNT ?= /home/${DOCKERUSER}
DOCKERHOME ?= ${HOME}/.dockervol
DOCKERVOL ?= ${DOCKERHOME}:${DOCKERMNT}:Z
DOCKERBUILDARGS ?=
DOCKERBUILDFLAGS ?= ${DOCKERBUILDARGS} \
					-t ${DOCKERREPO}:${DOCKERTAG} \
					-f ${DOCKERFILE}

# Run-time variables
DOCKERFLAGS ?= --rm -it -v ${DOCKERVOL}

DOCKERRM_CONTAINERS = $(shell docker ps -a --format="{{.ID}}")
DOCKERRM_IMAGES = $(shell docker images -a --format="{{.ID}}")

DOCKERSSH = ${DOCKERHOME}/.ssh
GITUSER = gituser.txt

all: run

build:
	${DOCKERBIN} build ${DOCKERBUILDFLAGS} ${DOCKERPATH} 2>&1 | \
		tee devenv_build.out

install:
	mkdir -p ${DOCKERHOME}
	chmod 700 ${DOCKERHOME}

	if [ -f ${GITUSER} ]; then mv ${GITUSER} dockerenv; fi
	if [ -d ${HOME}/.ssh ]; then cp -fpr ${HOME}/.ssh ${DOCKERHOME}; fi
	if [ -d ${DOCKERSSH} ]; then chmod 700 ${DOCKERSSH}; \
		chmod 400 ${DOCKERSSH}/id_rsa*; fi

	cp -fr dockerenv/. ${DOCKERHOME}

# For security purposes, ${DOCKERHOME} should only have owner-write permissions
run: build install
	${DOCKERBIN} run ${DOCKERFLAGS} ${DOCKERREPO}:${DOCKERTAG} ${DOCKERCMD}

clean:
	${DOCKERBIN} rm ${DOCKERRM_CONTAINERS} > /dev/null 2>&1 || true

purge: clean
	${DOCKERBIN} rmi ${DOCKERRM_IMAGES} > /dev/null 2>&1 || true
