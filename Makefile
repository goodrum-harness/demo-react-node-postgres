# Makefile
# Standard top-level shared Makefile switchboard to consolidate all common
# rules which will be used when testing or executing this repository.
#

# Auto-include a Makefile.local if it exists in this local directory
ifneq ("$(wildcard Makefile.local)", "")
	include Makefile.local
endif

ifeq ($(DOCKER_COMMAND),)
	DOCKER_COMMAND=docker
endif
ifeq ($(DOCKER_IMAGE),)
	DOCKER_IMAGE=alpine
endif
ifeq ($(DOCKER_TAG),)
	DOCKER_TAG=latest
endif
ifeq ($(DOCKER_ENV),)
	DOCKER_ENV:=
endif
ifeq ($(DOCKER_MOUNTS),)
	DOCKER_MOUNTS:=
endif
ifeq ($(DOCKER_PORTS),)
	DOCKER_PORTS:=
endif
ifeq ($(DOCKER_NETWORK),)
	DOCKER_NETWORK:=demoapp
endif
ifeq ($(RUN_FLAGS),)
	RUN_FLAGS:=--rm -it
endif
ifeq ($(COMMAND_ARGS),)
	COMMAND_ARGS:=
endif
ifeq ($(PROJECT_DIR),)
	PROJECT_DIR:=${PWD}
endif
ifeq ($(TEMPLATE_DIR),)
	TEMPLATE_DIR:=.
endif
ifeq ($(RESOURCE),)
	RESOURCE:=
endif
WORKDIR=/project
WORKSPACE=../${TEMPLATE_DIR}
IMAGE_NAME=

ifeq ($(DOCKERFILE),)
	DOCKERFILE:=Dockerfile
endif
DOCKER_RUN=${DOCKER_COMMAND} run ${RUN_FLAGS} --name ${CONTAINER_NAME} --hostname ${CONTAINER_NAME} --network ${DOCKER_NETWORK} ${DOCKER_PORTS} ${DOCKER_ENV} -v ${PROJECT_DIR}:/project ${DOCKER_MOUNTS} -w ${WORKDIR}/${TEMPLATE_DIR} $(ENTRYPOINT) ${DOCKER_IMAGE}:${DOCKER_TAG} ${COMMAND_ARGS}

.PHONY: network
network:
	@(${DOCKER_COMMAND} network create ${DOCKER_NETWORK} --driver bridge || echo "Network already exists")

.PHONY: cleanup
cleanup:
	@(${DOCKER_COMMAND} rm -f ${CONTAINER_NAME} || echo "No container ${CONTAINER_NAME} exists")


# Additional Dockerfile Build Arguments
ifneq ($(DOCKER_ARGS),)
	DOCKER_ARGS_CMD=${DOCKER_ARGS}
endif

# Additional Docker build command flags - e.g --progress plain --no-cache
ifeq ($(BUILD_FLAGS),)
	BUILD_FLAGS=
endif

.PHONY: build
build:
	${DOCKER_COMMAND} build ${BUILD_FLAGS} -f ${WORKSPACE}/${DOCKERFILE} ${DOCKER_ARGS_CMD} -t ${IMAGE_NAME} ${WORKSPACE}

.PHONY: push
push:
	${DOCKER_COMMAND} push --all-platforms ${IMAGE_NAME}