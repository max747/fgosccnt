.PHONY: prepare docker-build docker-tag docker-login docker-push

DOCKER_TAG := max747/fgosccnt
ECR_URI := 669490731393.dkr.ecr.ap-northeast-1.amazonaws.com/max747/fgosccnt

prepare:
	python3 makeitem.py
	python3 makechest.py
	python3 makecard.py

docker-build:
	docker build . -t $(DOCKER_TAG)

docker-tag:
	$(eval REV=$(shell git rev-parse --short HEAD))
	docker tag $(DOCKER_TAG):latest $(ECR_URI):latest
	docker tag $(DOCKER_TAG):latest $(ECR_URI):$(REV)

docker-login:
	$$(aws ecr get-login --no-include-email --region ap-northeast-1)

docker-push: docker-tag
	$(eval REV=$(shell git rev-parse --short HEAD))
	docker push $(ECR_URI):latest
	docker push $(ECR_URI):$(REV)
