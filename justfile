DC := "docker compose"
D := "docker"
pwd := env_var('PWD')
source_venv := pwd + "/backend/venv"
target_venv := "/opt/venv"
backend_image := "facelo:development"
backend_dir := pwd + "/backend"
frontend_dir := pwd + "/frontend"
workdir := "/facelo"

init: build

test:
  echo {{D}}


exec-sh service:
    {{DC}} exec -it {{service}} sh

run-sh service:
    {{DC}} run -it --rm {{service}} sh


# -------------------------backend stuff
poetry-install:
    # {{DC}} run --rm backend poetry install --with dev --sync
    {{DC}} run --rm backend poetry install --extras "dev"

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
	docker build --target builder --tag {{backend_image}} {{backend_dir}}
	{{DC}} build

logs service='':
	{{DC}} logs -f {{service}}

sh service='':
	{{DC}} run --rm {{service}} /bin/bash

clean: down
	sudo rm -Rf {{source_venv}}
