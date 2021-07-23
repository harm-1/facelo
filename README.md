# docker commands
To start in develop or production mode.
```console
foo@bar:~$ docker-compose up dev
foo@bar:~$ docker-compose up prod
```

To open a shell in  the running container. 
```console
foo@bar:~$ docker exec -it facelo_dev_1 /bin/bash
```

To run commands using the flask CLI:
```console
foo@bar:~$ docker-compose run --rm manage <<command>>
```

This allows the standars flask commands: 
```console
foo@bar:~$ docker-compose run --rm manage shell
```
and built in commands:
```console
foo@bar:~$ docker-compose run --rm manage db init
foo@bar:~$ docker-compose run --rm manage db migrate
foo@bar:~$ docker-compose run --rm manage db upgrade
foo@bar:~$ docker-compose run --rm manage test
foo@bar:~$ docker-compose run --rm manage lint
```

To connect to the database from the cli:
```console
fooo@bar:~$ docker-compose exec db_dev mysql -uroot -pexample
```
start pipenv
```console
fooo@bar:~$ pipenv shell
```

To rebuild the image when dependencies change or the Dockerfile is modified. 
```console
$ docker-compose build
```
