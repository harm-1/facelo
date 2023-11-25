DC := "docker compose"
D := "docker"
pwd := env_var('PWD')
source_venv := pwd + "/backend/venv"
target_venv := "/opt/venv"
builder_image := "facelo:builder"
backend_dir := pwd + "/backend"
frontend_dir := pwd + "/frontend"
workdir := "/facelo"

init: build mkdir-venv create-venv

test:
  echo {{D}}

# -------------------------backend stuff
pip-reset:
	sudo rm -Rf {{source_venv}}
	mkdir -p {{source_venv}}

mkdir-venv:
	mkdir -p {{source_venv}}

create-venv:
	{{D}} run --rm -it \
	--mount type=bind,source={{source_venv}},target={{target_venv}} \
	{{builder_image}} python3 -m venv {{target_venv}}

pipenv-shell:
	{{D}} run --rm -it \
	--mount type=bind,source={{source_venv}},target={{target_venv}} \
	--mount type=bind,source={{backend_dir}},target={{workdir}} \
	{{builder_image}} bash

pipenv-sync-dev package='':
	{{D}} run --rm -it \
	--mount type=bind,source={{source_venv}},target={{target_venv}} \
	--mount type=bind,source={{	backend_dir}},target={{workdir}} \
	{{builder_image}} pipenv sync --dev {{package}}

pipenv-update package='':
	{{D}} run --rm -it \
	--mount type=bind,source={{source_venv}},target={{target_venv}} \
	--mount type=bind,source={{backend_dir}},target={{workdir}} \
	{{builder_image}} pipenv update {{package}}

pipenv-lock:
	{{D}} run --rm -it \
	--mount type=bind,source={{source_venv}},target={{target_venv}} \
	--mount type=bind,source={{backend_dir}},target={{workdir}} \
	{{builder_image}} pipenv lock


poetry-shell:
	{{D}} run --rm -it \
	--mount type=bind,source={{source_venv}},target={{target_venv}} \
	--mount type=bind,source={{backend_dir}},target={{workdir}} \
	{{builder_image}} bash

poetry-update:
	{{D}} run --rm -it \
	--mount type=bind,source={{source_venv}},target={{target_venv}} \
	--mount type=bind,source={{backend_dir}},target={{workdir}} \
	{{builder_image}} poetry update

poetry-lock:
	{{D}} run --rm -it \
	--mount type=bind,source={{source_venv}},target={{target_venv}} \
	--mount type=bind,source={{backend_dir}},target={{workdir}} \
	{{builder_image}} poetry lock --directory={{workdir}}/backend

poetry-install:
	{{D}} run --rm -it \
	--mount type=bind,source={{source_venv}},target={{target_venv}} \
	--mount type=bind,source={{backend_dir}},target={{workdir}} \
	{{builder_image}} poetry install --directory={{workdir}}/backend


# (init/migrate/upgrade}}
flask-db command:
	{{DC}} run --rm backend flask db {{command}}

flask-shell:
	{{DC}} run --rm backend flask shell

flask-seed:
	{{DC}} run --rm backend flask seed

# ----------------------------------flutter stuff
flutter-chrome:
	{{DC}} up -d backend
	(cd flutter_app ; flutter run -d chrome)

# --------------------------------db stuff
db-cli:
	{{D}} exec -it facelo-database-1 mysql -ufacelo -ppassword facelo_testing
	# {{DC}} run --rm database mysql

# ----------------------------------docker stuff
up service='':
	{{DC}} up -d {{service}}

up-attach service='':
	{{DC}} up {{service}}

down service='':
	{{DC}} down {{service}}

restart service='':
	{{DC}} restart {{service}}

build:
	docker build --target builder --tag {{builder_image}} {{backend_dir}}
	{{DC}} build

logs service='':
	{{DC}} logs -f {{service}}

sh service='':
	{{DC}} run --rm {{service}} /bin/bash

clean: down
	sudo rm -Rf {{source_venv}}
