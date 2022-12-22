.PHONY: all build

DOCKER=docker
IMAGE=ghcr.io/smkwlab/textlint-docker

all: build

build:
	$(DOCKER) image build -t $(IMAGE) .

push:
	$(DOCKER) push $(IMAGE)
