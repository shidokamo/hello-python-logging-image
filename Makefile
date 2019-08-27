REPO=gcr.io
PROJECT:= $(shell gcloud config get-value project)
PREFIX := ${REPO}/${PROJECT}
IMAGE := hello-python-logging
TAG = 1.0.0

default:build push

requirements:
	pipenv lock -r > requirements.txt
build:requirements
	docker build --pull -t $(PREFIX)/${IMAGE}:$(TAG) .
push:
	gcloud docker -- push $(PREFIX)/${IMAGE}:$(TAG)

# Local debug (with Docker)
run:
	docker run -itd --env LOG_INTERVAL=0.1 $(PREFIX)/${IMAGE}:$(TAG)

# Local debug (no Docker)
log:clean
	pipenv run python -u hello.py
clean:
	-rm txt*

