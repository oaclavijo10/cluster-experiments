.PHONY: clean clean-test clean-pyc clean-build

black:
	black cluster_experiments tests setup.py --check

flake:
	flake8 cluster_experiments tests setup.py

test:
	pytest

check: black flake test

install:
	python -m pip install -e .

install-dev:
	pip install --upgrade pip setuptools wheel
	python -m pip install -e ".[dev]"
	pre-commit install

install-test:
	pip install --upgrade pip setuptools wheel
	python -m pip install -e ".[test]"

docs-deploy:
	mkdocs gh-deploy

docs-serve:
	mkdocs serve

clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache

pypi: clean
	python setup.py sdist
	python setup.py bdist_wheel --universal
	twine upload dist/*
