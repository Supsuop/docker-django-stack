# An easy to use docker django stack

## Purpose

The purpose of this docker stack is to provide a basic environment for django.

## How to use it

Customize all .env files as you like.\
The passwords are generated automatically and therefore do not need to be changed.

Start `init-project.sh`\
This creates the necessary data for the project

~~~bash
./init-project.sh
~~~

Start docker

~~~bash
docker compse up
~~~

## FAQ

### How exactly does the init-project.sh script work?

The script reads all necessary information from the .env files.
Afterwards a python container is started, which then installs django.\
This data is then stored in the folder `./django/app/`.
If files are already stored in the folder, the script is not executed.

### Is it possible to change the versions?

The python and django version can be customized via .env.
This setting is only relevant during initialization.

### Why are there already values for the passwords stored in the env?

Since they are overwritten during initialization, I left them as a dummy entry.
The password for the database and the secret key for django are automatically generated with "openssl rand -hex 32".

### Why do you use a healthcheck for the postgres container?

I had to include a "healthcheck" because the depends_on function didn't work properly with the django container.
As it seems, the image of postgres has no healthceck integrated.

### Can I integrate my own environment into your docker template?

Unfortunately I can't give an exact specification here, because every installation is different.\
However, I can share some thoughts with you.

1. the requirements.txt file should be overwritten
2. use the correct python version
3. check docker compose if the volumes match your installation
