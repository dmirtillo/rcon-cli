# If the first argument is "docker-deploy"...
ifeq (compile, $(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

.PHONY: compile run deps test build lint

compile:
	sh scripts/local/compile.sh $(RUN_ARGS)

run:
	sh scripts/local/run.sh

deps:
	go mod download
	go mod verify

test:
	go test -v ./...

build:
	go build -v ./cmd/gorcon

lint:
	go run github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.10.1 run --config=.golangci.yml
