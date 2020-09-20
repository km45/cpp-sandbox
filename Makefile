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
	docker-compose exec --user `id -u`:`id -g` develop bash

.PHONY: clean
clean:
	docker-compose exec --user `id -u`:`id -g` develop bash -c "rm -rf build"

.PHONY: cmake
cmake:
	docker-compose exec --user `id -u`:`id -g` develop bash -c "mkdir -p build && cd build && cmake -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .."

.PHONY: build
build: cmake
	docker-compose exec --user `id -u`:`id -g` develop bash -c "cmake --build build"

.PHONY: test
test: build
	docker-compose exec --user `id -u`:`id -g` develop bash -c "cmake --build build --target test"

.PHONY: exec
exec:
	docker-compose exec --user `id -u`:`id -g` develop bash -c "./build/sandbox"

.PHONY: dependencies
dependencies:
	rm -rf dependencies
	mkdir -p dependencies
	docker-compose exec --user `id -u`:`id -g` develop bash -c "cp -pr submodules/indicators/include/indicators dependencies/"
