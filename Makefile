REPO=gcr.io
PROJECT:= $(shell gcloud config get-value project)
PREFIX := ${REPO}/${PROJECT}
IMAGE := test-logger
TAG = 2.0.0
LOG_INTEVAL =
export LOG_INTERVAL

default:build push

# Local debug (no Docker)
install:
	pipenv install
	bundle install --path=./vendor/bundle
log:
	pipenv run python -u code/app.py
clean:
	-rm -rf *.log*
	-rm -rf country
fluentd:
	bundle exec fluentd -c fluent.conf

# build
requirements:
	pipenv lock -r > requirements.txt
build:requirements
	docker build --pull -t $(PREFIX)/${IMAGE}:$(TAG) .
build-clean:requirements
	docker build --no-cache -t $(PREFIX)/${IMAGE}:$(TAG) .
push:
	gcloud docker -- push $(PREFIX)/${IMAGE}:$(TAG)

# Local debug (with Docker)
run:
	docker run -itd --name ${IMAGE} --env LOG_INTERVAL=${LOG_INTERVAL} $(PREFIX)/${IMAGE}:$(TAG)
login:
	docker exec -it ${IMAGE} /bin/sh
kill:
	docker kill ${IMAGE}

