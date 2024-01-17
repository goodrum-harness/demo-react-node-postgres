PROJECT_DIR=${PWD}/../
TEMPLATE_DIR=$(notdir $(shell pwd))

# Auto-include the repository root Makefile to access shared resources
ifneq ("$(wildcard ../Makefile)", "")
	include ../Makefile
endif
ifneq ("$(wildcard ../Makefile.local)", "")
	include ../Makefile.local
endif


CONTAINER_NAME=demo-frontend
DOCKER_IMAGE=node
DOCKER_TAG=20.11.0-alpine
DOCKER_PORTS=-p 8081:8081
COMMAND_ARGS=npm start

ifneq ("$(wildcard Makefile.local)", "")
	include Makefile.local
endif

.PHONY: debug
debug: cleanup network
	$(eval ENTRYPOINT=--entrypoint sh)
	$(eval COMMAND_ARGS=)
	@(${DOCKER_RUN})

.PHONY: logs
logs:
	${DOCKER_COMMAND} logs -f ${CONTAINER_NAME}

.PHONY: deploy
deploy: cleanup network
	@(${DOCKER_RUN})

.PHONY: connect
connect:
	${DOCKER_COMMAND} exec -it ${CONTAINER_NAME} sh
