PROJECT_DIR=${PWD}/../
TEMPLATE_DIR=$(notdir $(shell pwd))

# Auto-include the repository root Makefile to access shared resources
ifneq ("$(wildcard ../Makefile)", "")
	include ../Makefile
endif
ifneq ("$(wildcard ../Makefile.local)", "")
	include ../Makefile.local
endif

CONTAINER_NAME=demo-backend
DOCKER_IMAGE=node
DOCKER_TAG=20.11.0-alpine
DOCKER_PORTS=-p 8080:8080
COMMAND_ARGS=server.js

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
	$(eval RUN_FLAGS=-d)
	@(${DOCKER_RUN})
