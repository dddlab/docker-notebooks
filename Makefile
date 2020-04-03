# simplified from
# https://github.com/jupyter/docker-stacks/blob/master/Makefile

.PHONY: docs help test

# Use bash for inline if-statements in arch_patch target
SHELL:=bash
OWNER?=dddlab

# Need to list the images in build dependency order
ALL_STACKS:=asdf \
	qwer

ALL_IMAGES:=$(ALL_STACKS)

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@echo "jupyter/docker-stacks"
	@echo "====================="
	@echo "Replace % with a stack directory name (e.g., make build/minimal-notebook)"
	@echo
	@grep -E '^[a-zA-Z0-9_%/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build/%: DARGS?=
build/%: ## build the latest image for a stack
	docker build $(DARGS) --rm --force-rm -t $(OWNER)/$(notdir $@):$(DTAG) ./$(notdir $@)
	docker tag $(OWNER)/$(notdir $@):$(DTAG) $(OWNER)/$(notdir $@):latest-testing
	docker push $(OWNER)/$(notdir $@):$(DTAG)
	docker push $(OWNER)/$(notdir $@):latest-testing

build-all: $(foreach I,$(ALL_IMAGES),arch_patch/$(I) build/$(I) ) ## build all stacks
build-test-all: $(foreach I,$(ALL_IMAGES),arch_patch/$(I) build/$(I) test/$(I) ) ## build and test all stacks

dev/%: ARGS?=
dev/%: DARGS?=
dev/%: PORT?=8888
dev/%: ## run a foreground container for a stack
	docker run -it --rm -p $(PORT):8888 $(DARGS) $(OWNER)/$(notdir $@) $(ARGS)

run/%: ## run a bash in interactive mode in a stack
	docker run -it --rm $(OWNER)/$(notdir $@) $(SHELL)

run-sudo/%: ## run a bash in interactive mode as root in a stack
	docker run -it --rm -u root $(OWNER)/$(notdir $@) $(SHELL)
