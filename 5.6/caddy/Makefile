BUILD_NAME := 'local/php-5.6-caddy'

# bins
DOCKER := $(shell which docker)

all: build

build:
	${DOCKER} build -t ${BUILD_NAME}:latest   .

build-no-cache:
	${DOCKER} build --rm --no-cache -t ${BUILD_NAME}:latest   .	