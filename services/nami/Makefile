.PHONY: setup install run clean

VENV := venv
PYTHON := $(VENV)/bin/python
PIP := $(VENV)/bin/pip

setup:
	python3 -m venv venv
	. venv/bin/activate && pip install --upgrade pip

install: setup
	. venv/bin/activate && pip install fastapi uvicorn[standard]

run:
	. venv/bin/activate && uvicorn main:app --reload

clean:
	rm -rf venv