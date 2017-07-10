DBG_MAKEFILE ?=
ifeq ($(DBG_MAKEFILE),1)
	$(warning ***** starting Makefile for goal(s) "$(MAKECMDGOALS)")
	$(warning ***** $(shell date))
else
	MAKEFLAGS += -s
endif

# Metadata for driving the build lives here.
META_DIR := .make
SHELL := /usr/bin/env bash

.PHONY: help install-hooks run-hooks

default: help

help:

	@echo "---> Help menu:"
	@echo ""
	@echo "Help output:"
	@echo "make help"
	@echo ""
	@echo "Install pre-commit hooks"
	@echo "make install-hooks"
	@echo ""
	@echo "Clean the repo of pre-commit hooks"
	@echo "make clean-hooks"
	@echo ""
	@echo "Run pre-commit hooks locally"
	@echo "make run-hooks"
	@echo ""

install-hooks:
	pip install -r requirements.txt
	pip install --upgrade pre-commit
	pre-commit install --install-hooks
	pre-commit autoupdate

clean-hooks:
	pre-commit clean
	pre-commit uninstall

run-hooks: install-hooks
	pre-commit run --all-files
