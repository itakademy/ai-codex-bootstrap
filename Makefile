SHELL := /bin/bash

.PHONY: help check validate-env changelog lint lint-md lint-shell test \
	test-static test-web test-api new-spec new-adr new-recipe init-repo \
	install-skills add-submodule-static add-submodule-web add-submodule-api \
	submodules-sync submodules-update setup-env setup-hooks bootstrap-static \
	bootstrap-next bootstrap-laravel dev dev-static dev-web dev-api sst-dev \
	sst-deploy sst-remove recipe-save

help:
	@echo "Available targets:"
	@echo "  make check             Validate local tooling"
	@echo "  make validate-env      Validate .env against .env.schema"
	@echo "  make changelog         Rebuild CHANGELOG.md from git commit history"
	@echo "  make lint              Run markdown and shell linting"
	@echo "  make lint-md           Lint markdown files"
	@echo "  make lint-shell        Lint shell scripts with shellcheck"
	@echo "  make test              Run available local tests"
	@echo "  make test-static       Test apps/web-static if present"
	@echo "  make test-web          Run frontend tests from apps/web"
	@echo "  make test-api          Run Laravel tests from apps/api"
	@echo "  make new-spec          Create specs/SPEC-XXX.md with TITLE=\"...\""
	@echo "  make new-adr           Create docs/adr/ADR-XXX-title.md with TITLE=\"...\""
	@echo "  make new-recipe        Create recipes/<slug>.md with TITLE=\"...\""
	@echo "  make init-repo         Initialize git locally and install hooks when available"
	@echo "  make install-skills    Install repo skills into \$${CODEX_HOME:-~/.codex}/skills"
	@echo "  make add-submodule-static URL=... [BRANCH=main]"
	@echo "  make add-submodule-web URL=... [BRANCH=main]"
	@echo "  make add-submodule-api URL=... [BRANCH=main]"
	@echo "  make submodules-sync   Sync and initialize submodules"
	@echo "  make submodules-update Update submodules to recorded commits"
	@echo "  make setup-env         Create .envrc from .envrc.example if missing"
	@echo "  make setup-hooks       Install pre-commit hooks if pre-commit is available"
	@echo "  make bootstrap-static  Create apps/web-static with a minimal static site"
	@echo "  make bootstrap-next    Create apps/web with Next.js"
	@echo "  make bootstrap-laravel Create apps/api with Laravel Sail"
	@echo "  make dev               Start the best available local dev server"
	@echo "  make dev-static        Serve apps/web-static on http://127.0.0.1:3000"
	@echo "  make dev-web           Start Next.js dev server from apps/web"
	@echo "  make dev-api           Start Laravel Sail from apps/api"
	@echo "  make sst-dev           Start SST dev mode"
	@echo "  make sst-deploy        Deploy the current stack"
	@echo "  make sst-remove        Remove the current stack"
	@echo "  make recipe-save       Create a reusable recipe markdown file"

check:
	./scripts/check-env.sh

validate-env:
	@python3 ./scripts/validate-env.py

changelog:
	@python3 ./scripts/update-changelog.py

lint: lint-md lint-shell

lint-md:
	@npx markdownlint-cli2

lint-shell:
	@if ! command -v shellcheck >/dev/null 2>&1; then \
		echo "shellcheck is not installed"; \
		exit 1; \
	fi
	@shellcheck scripts/*.sh scripts/lib/*.sh

test:
	@found=0; \
	if [[ -f apps/web-static/index.html ]]; then \
		found=1; \
		$(MAKE) test-static || exit $$?; \
	fi; \
	if [[ -f apps/web/package.json ]]; then \
		found=1; \
		$(MAKE) test-web || exit $$?; \
	fi; \
	if [[ -f apps/api/artisan ]]; then \
		found=1; \
		$(MAKE) test-api || exit $$?; \
	fi; \
	if [[ $$found -eq 0 ]]; then \
		echo "No app found under apps/. Nothing to test yet."; \
	fi

test-static:
	@python3 ./scripts/test-static.py

test-web:
	@if [[ ! -d apps/web ]]; then \
		echo "Missing apps/web. Run 'make bootstrap-next' first."; \
		exit 1; \
	fi
	@if [[ ! -f apps/web/package.json ]]; then \
		echo "Missing apps/web/package.json"; \
		exit 1; \
	fi
	@if ! node -e 'const pkg=require("./apps/web/package.json"); process.exit(pkg.scripts && pkg.scripts.test ? 0 : 1)'; then \
		echo "apps/web exists but has no test script in package.json"; \
		exit 1; \
	fi
	@cd apps/web && npm test

test-api:
	@if [[ ! -d apps/api ]]; then \
		echo "Missing apps/api. Run 'make bootstrap-laravel' first."; \
		exit 1; \
	fi
	@if [[ ! -f apps/api/artisan ]]; then \
		echo "Missing apps/api/artisan"; \
		exit 1; \
	fi
	@cd apps/api && php artisan test

new-spec:
	@if [[ -z "$(TITLE)" ]]; then \
		echo "TITLE is required. Example: make new-spec TITLE=\"Titre de la spec\""; \
		exit 1; \
	fi
	@python3 ./scripts/new-spec.py --title "$(TITLE)"

new-adr:
	@if [[ -z "$(TITLE)" ]]; then \
		echo "TITLE is required. Example: make new-adr TITLE=\"Decision d'architecture\""; \
		exit 1; \
	fi
	@python3 ./scripts/new-adr.py --title "$(TITLE)"

new-recipe:
	@if [[ -z "$(TITLE)" ]]; then \
		echo "TITLE is required. Example: make new-recipe TITLE=\"Nom de la recipe\""; \
		exit 1; \
	fi
	@python3 ./scripts/new-recipe.py --title "$(TITLE)"

init-repo:
	@./scripts/init-repo.sh

install-skills:
	@./scripts/install-skills.sh

add-submodule-static:
	@if [[ -z "$(URL)" ]]; then \
		echo "URL is required. Example: make add-submodule-static URL=git@github.com:org/product-web-static.git"; \
		exit 1; \
	fi
	@./scripts/submodule-add.sh "$(URL)" "apps/web-static" "$(BRANCH)"

add-submodule-web:
	@if [[ -z "$(URL)" ]]; then \
		echo "URL is required. Example: make add-submodule-web URL=git@github.com:org/product-web.git"; \
		exit 1; \
	fi
	@./scripts/submodule-add.sh "$(URL)" "apps/web" "$(BRANCH)"

add-submodule-api:
	@if [[ -z "$(URL)" ]]; then \
		echo "URL is required. Example: make add-submodule-api URL=git@github.com:org/product-api.git"; \
		exit 1; \
	fi
	@./scripts/submodule-add.sh "$(URL)" "apps/api" "$(BRANCH)"

submodules-sync:
	@./scripts/submodules-sync.sh

submodules-update:
	@./scripts/submodules-update.sh

setup-env:
	@if [[ -f .envrc ]]; then \
		echo ".envrc already exists"; \
	elif [[ -f .envrc.example ]]; then \
		cp .envrc.example .envrc; \
		echo "Created .envrc from .envrc.example"; \
		echo "Run 'direnv allow' to enable automatic env loading."; \
	else \
		echo "Missing .envrc.example"; \
		exit 1; \
	fi

setup-hooks:
	@if ! command -v pre-commit >/dev/null 2>&1; then \
		echo "pre-commit is not installed"; \
		exit 1; \
	fi
	@pre-commit install
	@echo "pre-commit hooks installed"

bootstrap-static:
	./scripts/bootstrap-static.sh

bootstrap-next:
	./scripts/bootstrap-next.sh

bootstrap-laravel:
	./scripts/bootstrap-laravel.sh

dev:
	@if [[ -f apps/web/package.json ]]; then \
		$(MAKE) dev-web; \
	elif [[ -f apps/web-static/index.html ]]; then \
		$(MAKE) dev-static; \
	elif [[ -f apps/api/artisan ]]; then \
		$(MAKE) dev-api; \
	else \
		echo "No app found under apps/."; \
		echo "Use 'make bootstrap-next', 'make bootstrap-laravel', or add a product submodule first."; \
		exit 1; \
	fi

dev-static:
	@if [[ ! -d apps/web-static ]]; then \
		echo "Missing apps/web-static"; \
		exit 1; \
	fi
	@echo "Serving static app on http://127.0.0.1:3000"
	@cd apps/web-static && python3 -m http.server 3000

dev-web:
	@if [[ ! -d apps/web ]]; then \
		echo "Missing apps/web. Run 'make bootstrap-next' first."; \
		exit 1; \
	fi
	@if [[ ! -f apps/web/package.json ]]; then \
		echo "Missing apps/web/package.json"; \
		exit 1; \
	fi
	@if [[ ! -d apps/web/node_modules ]]; then \
		echo "Installing web dependencies in apps/web"; \
		cd apps/web && npm install; \
	fi
	@echo "Starting Next.js on http://127.0.0.1:3000"
	@cd apps/web && npm run dev

dev-api:
	@if [[ ! -d apps/api ]]; then \
		echo "Missing apps/api. Run 'make bootstrap-laravel' first."; \
		exit 1; \
	fi
	@if [[ ! -x apps/api/vendor/bin/sail ]]; then \
		echo "Missing Laravel Sail. Run 'make bootstrap-laravel' first."; \
		exit 1; \
	fi
	@echo "Starting Laravel Sail. API will be available on the app port configured by Sail."
	@cd apps/api && ./vendor/bin/sail up

sst-dev:
	npm run sst:dev

sst-deploy:
	npm run sst:deploy

sst-remove:
	npm run sst:remove

recipe-save:
	python3 ./scripts/save-recipe.py
