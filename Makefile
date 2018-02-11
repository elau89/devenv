# Docker commands
DOCKERBIN ?= docker
DOCKERCMD ?=

# Build-time variables
DOCKERFILE ?= Dockerfile
DOCKERPATH ?= .
DOCKERREPO ?= devenv
DOCKERTAG ?= latest

DOCKERUSER ?= dockeruser
DOCKERMNT ?= /home/${DOCKERUSER}/shared
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

all: run

build:
	${DOCKERBIN} build ${DOCKERBUILDFLAGS} ${DOCKERPATH}

# For security purposes, ${DOCKERHOME} should only have owner-write permissions
run: build
	mkdir -p ${DOCKERHOME}
	chmod 700 ${DOCKERHOME}
	${DOCKERBIN} run ${DOCKERFLAGS} ${DOCKERREPO}:${DOCKERTAG} ${DOCKERCMD}

clean:
	${DOCKERBIN} rm ${DOCKERRM_CONTAINERS} > /dev/null 2>&1 || true

purge: clean
	${DOCKERBIN} rmi ${DOCKERRM_IMAGES} > /dev/null 2>&1 || true
