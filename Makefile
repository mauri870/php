BUILD_BASE ?= local/php

DOCKER ?= $(shell which docker)

# We only use the 7.2 images, the others are deprecated
VERSION ?= 7.3
VARIANT ?= web

BUILD_NAME = $(BUILD_BASE):$(VERSION)-$(VARIANT)
BUILD_DIR = $(VERSION)/$(VARIANT)

all: build

build:
	$(DOCKER) build --no-cache -t $(BUILD_NAME) $(BUILD_DIR)

build-no-cache:
	$(DOCKER) build --rm --no-cache -t $(BUILD_NAME) $(BUILD_DIR)
