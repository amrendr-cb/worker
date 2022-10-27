.DEFAULT_GOAL := help
.SILENT:

ROOT_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

## Display usage
help:
	@awk '/^[a-zA-Z\-\_0-9%:\\\/]+:/ { \
	  helpMessage = match(lastLine, /^## (.*)/); \
	  if (helpMessage) { \
	    helpCommand = $$1; \
	    helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
      gsub("\\\\", "", helpCommand); \
      gsub(":+$$", "", helpCommand); \
	    printf "  \x1b[32;01m%-35s\x1b[0m %s\n", helpCommand, helpMessage; \
	  } \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST) | sort -u
	@printf "\n"

## Format the source code
format:
	terraform fmt

## Generate the documentation for the Terraform variables and outputs
generate-docs:
	terraform-docs .

## Lint the source code
lint:
	tflint .
