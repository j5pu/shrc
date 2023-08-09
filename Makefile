.PHONY: install jetbrains profile tests tests-bats tests-deps

SHELL := $(shell command -v bash)
DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
basename := $(shell basename $(DIR))

install: profile jetbrains

jetbrains:
	@jetbrains plist

profile:
	@sudo mv /etc/profile /etc/profile.bk
	@sudo sed -i "" 's|export SHRC=.*|export SHRC="$(DIR)"|' $(DIR)/files/profile
	@sudo relative $(DIR)/files/profile /etc/profile

tests: tests-deps tests-bats

tests-bats:
	@bash -l -c "bin/bats tests"

tests-deps:
	@/usr/local/bin/brew bundle --file tests/Brewfile --quiet --no-lock | grep -v "^Using"


keys:
	wget -O .ssh/authorized_keys  https://github.com/j5pu.keys
