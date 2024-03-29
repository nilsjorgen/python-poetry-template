# Defines all tasks found in the file as .PHONY.
.PHONY: $(shell sed -n -e '/^$$/ { n ; /^[^ .\#][^ ]*:/ { s/:.*$$// ; p ; } ; }' $(MAKEFILE_LIST))

help:
	 @echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

update: ## Updates the dependencies to the latest version.
	@poetry --version || brew install poetry
	poetry update

test: ## Runs all tests using pytest.
	poetry install
	poetry run pytest

format: ## Formats the source code using the Black formatter.
	poetry run black SRC
