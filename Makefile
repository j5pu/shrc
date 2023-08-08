.PHONY: tests tests-bats tests-deps

SHELL := $(shell command -v bash)
DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
basename := $(shell basename $(DIR))

set:
	set
tests: tests-bats

tests-bats:
	@bin/bats tests

tests-deps:
	@/usr/local/bin/brew bundle --file tests/Brewfile --quiet --no-lock | grep -v "^Using"
