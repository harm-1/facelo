DC := docker compose
D := docker
pwd = $(shell pwd)
source_venv := $(pwd)/backend/venv
target_venv := /opt/venv
builder_image := facelo:builder
backend_dir := $(pwd)/backend
frontend_dir := $(pwd)/frontend
workdir := /facelo

init: build mkdir-venv create-venv

# -------------------------backend stuff
pip-reset:
	sudo rm -Rf $(source_venv)
	mkdir -p $(source_venv)

mkdir-venv:
	mkdir -p $(source_venv)

create-venv:
	$(D) run --rm -it \
	--mount type=bind,source=$(source_venv),target=$(target_venv) \
	$(builder_image) python3 -m venv $(target_venv)

pipenv-shell:
	$(D) run --rm -it \
	--mount type=bind,source=$(source_venv),target=$(target_venv) \
	--mount type=bind,source=$(backend_dir),target=$(workdir) \
	$(builder_image) bash

pipenv-sync-dev:
	$(D) run --rm -it \
	--mount type=bind,source=$(source_venv),target=$(target_venv) \
	--mount type=bind,source=$(	backend_dir),target=$(workdir) \
	$(builder_image) pipenv sync --dev $(p)

pipenv-update:
	$(D) run --rm -it \
	--mount type=bind,source=$(source_venv),target=$(target_venv) \
	--mount type=bind,source=$(backend_dir),target=$(workdir) \
	$(builder_image) pipenv update $(p)

pipenv-lock:
	$(D) run --rm -it \
	--mount type=bind,source=$(source_venv),target=$(target_venv) \
	--mount type=bind,source=$(backend_dir),target=$(workdir) \
	$(builder_image) pipenv lock

# (init/migrate/upgrade)
flask-db:
	$(DC) run --rm backend flask db $(c)

flask-shell:
	$(DC) run --rm backend flask shell

flask-seed:
	$(DC) run --rm backend flask seed

# ----------------------------------flutter stuff
flutter-chrome:
	$(DC) up -d backend
	(cd flutter_app ; flutter run -d chrome )

# --------------------------------db stuff
db-cli:
	$(D	) exec -it facelo-database-1 mysql -ufacelo -ppassword facelo_testing
	# $(DC) run --rm database mysql

# ----------------------------------docker stuff
up:
	$(DC) up -d $(s)

up-attach:
	$(DC) up $(s)

down:
	$(DC) down $(s)

restart:
	$(DC) restart $(s)

build:
	docker build --target builder --tag $(builder_image) $(backend_dir)
	$(DC) build

logs:
	$(DC) logs -f $(s)

sh:
	$(DC) run --rm $(s) /bin/bash

clean: down
	sudo rm -Rf $(source_venv)
