PROJECT_DIR=${PWD}/../
TEMPLATE_DIR=$(notdir $(shell pwd))

# Auto-include the repository root Makefile to access shared resources
ifneq ("$(wildcard ../Makefile)", "")
	include ../Makefile
endif
ifneq ("$(wildcard ../Makefile.local)", "")
	include ../Makefile.local
endif
ifneq ("$(wildcard Makefile.local)", "")
	include Makefile.local
endif

CONTAINER_NAME=demo-db
DOCKER_IMAGE=postgres
DOCKER_TAG=16-alpine
DOCKER_PORTS=-p 5432:5432
DOCKER_ENV=-e POSTGRES_PASSWORD=mysecretpassword -e POSTGRES_DB=testdb

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

.PHONY: connect
connect:
	${DOCKER_COMMAND} exec -it ${CONTAINER_NAME} sh
