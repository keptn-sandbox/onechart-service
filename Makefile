.PHONY: test build docker-build docker-run docker-push deploy

all: test build

build:
	go build -ldflags '-linkmode=external' -v -o onechart-service

test:
	go test -race -v ./...

docker-build:
	docker build . -t gimletio/onechart-service:dev

docker-run:
	docker run --rm -it -p 8080:8080 gimletio/onechart-service:dev

docker-push:
	docker push gimletio/onechart-service:dev

deploy:
	kubectl apply -f deploy/
