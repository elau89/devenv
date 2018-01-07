DOCKERBIN ?= docker
DOCKERCMD ?=
DOCKERFILE ?= Dockerfile
DOCKERPATH ?= .
DOCKERREPO ?= dev
DOCKERTAG ?= latest

DOCKERUSER ?= dockeruser
DOCKERMNT ?= /home/${DOCKERUSER}/shared
DOCKERHOME ?= ${HOME}/.dockervol
DOCKERVOL ?= ${DOCKERHOME}:${DOCKERMNT}:Z
DOCKERFLAGS ?= --rm -it -v ${DOCKERVOL}

DOCKERRM_CONTAINERS = $(shell docker ps -a --format="{{.ID}}")
DOCKERRM_IMAGES = $(shell docker images -a --format="{{.ID}}")

all: run

build:
	${DOCKERBIN} build -t ${DOCKERREPO}:${DOCKERTAG} -f ${DOCKERFILE} ${DOCKERPATH}

run: build
	mkdir -p ${DOCKERHOME}
	${DOCKERBIN} run ${DOCKERFLAGS} ${DOCKERREPO}:${DOCKERTAG} ${DOCKERCMD}

clean:
	${DOCKERBIN} rm ${DOCKERRM_CONTAINERS} > /dev/null 2>&1 || true

purge: clean
	${DOCKERBIN} rmi ${DOCKERRM_IMAGES} > /dev/null 2>&1 || true
