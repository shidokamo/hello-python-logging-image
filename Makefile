REPO=gcr.io
PROJECT:= $(shell gcloud config get-value project)
PREFIX := ${REPO}/${PROJECT}
IMAGE := hello-python-logging
TAG = 1.0.0
LOG_INTEVAL =
export LOG_INTERVAL

default:build push

# Local debug (no Docker)
log:clean
	pipenv run python -u hello.py
clean:
	-rm txt*

# build
requirements:
	pipenv lock -r > requirements.txt
build:requirements
	docker build --pull -t $(PREFIX)/${IMAGE}:$(TAG) .
push:
	gcloud docker -- push $(PREFIX)/${IMAGE}:$(TAG)

# Local debug (with Docker)
run:
	docker run -itd --name ${IMAGE} --env LOG_INTERVAL=0.1 $(PREFIX)/${IMAGE}:$(TAG)
login:
	docker exec -it --name ${IMAGE} /bin/sh
kill:
	docker kill ${IMAGE}

