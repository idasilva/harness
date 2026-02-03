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


.PHONY: test coverage lint clean

test:
	pytest -v

coverage:
	pytest --cov=. --cov-report=html --cov-report=term-missing

lint:
	flake8 .
	black --check .

format:
	black .

clean:
	rm -rf .coverage coverage.xml htmlcov/ .pytest_cache/ .tox/ __pycache__/
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

install:
	pip install -r requirements.txt
	pip install pytest pytest-cov flake8 black

all: lint test coverage