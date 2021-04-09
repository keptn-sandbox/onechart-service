.PHONY: test build

all: test build

build:
	go build -ldflags '-linkmode=external' -v -o onechart-service

test:
	go test -race -v ./...
