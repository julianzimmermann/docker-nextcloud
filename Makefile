.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-40s\033[0m %s\n", $$1, $$2}'

.PHONY: docker-build
docker-build: ## build
	cd docker && docker-compose up -d --build

.PHONY: docker-up
docker-up: ## up
	cd docker && docker-compose start up -d

.PHONY: docker-start
docker-start: ## start
	cd docker && docker-compose start

.PHONY: docker-stop
docker-stop: ## stop
	cd docker && docker-compose stop

.PHONY: docker-down
docker-down: ## down
	cd docker && docker-compose down