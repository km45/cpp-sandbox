DOCKER_COMPOSE_EXEC_COMMAND_BASE := docker-compose exec
DOCKER_COMPOSE_EXEC_COMMAND_USER := --user `id -u`:`id -g`
DOCKER_COMPOSE_EXEC_COMMAND_TTY ?=
DOCKER_COMPOSE_EXEC_COMMAND := $(DOCKER_COMPOSE_EXEC_COMMAND_BASE) $(DOCKER_COMPOSE_EXEC_COMMAND_USER) $(DOCKER_COMPOSE_EXEC_COMMAND_TTY)

.PHONY: env-up
env-up:
	docker-compose up -d --build

.PHONY: env-down
env-down:
	docker-compose down

.PHONY: env-lint
env-lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

.PHONY: env-shell
env-shell:
	$(DOCKER_COMPOSE_EXEC_COMMAND) develop bash

.PHONY: clean
clean:
	$(DOCKER_COMPOSE_EXEC_COMMAND) develop bash -c "rm -rf build"

.PHONY: cmake
cmake:
	$(DOCKER_COMPOSE_EXEC_COMMAND) develop bash -c "mkdir -p build && cd build && cmake -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .."

.PHONY: build
build: cmake
	$(DOCKER_COMPOSE_EXEC_COMMAND) develop bash -c "cmake --build build"

.PHONY: test
test: build
	$(DOCKER_COMPOSE_EXEC_COMMAND) develop bash -c "cd build && ctest --verbose"

.PHONY: exec
exec:
	$(DOCKER_COMPOSE_EXEC_COMMAND) develop bash -c "./build/sandbox"

.PHONY: dependencies
dependencies:
	rm -rf dependencies
	mkdir -p dependencies
	$(DOCKER_COMPOSE_EXEC_COMMAND) develop bash -c "cp -pr submodules/indicators/include/indicators dependencies/"
