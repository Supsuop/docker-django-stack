#!/bin/bash
scriptpath=$(realpath "$0" | sed 's|\(.*\)/.*|\1|')
set -o allexport
# read necessary variables
source "$scriptpath"/django/.env
source "$scriptpath"/.env
set +o allexport

# checking if any file already exists
if [ ! "$(ls -A ./django/app/)" ]; then
    # pull newest image
    docker pull "$django_image":"$django_tag"

    # generate django project
    docker run --label type=django_builder -v "${PWD}"/django/app:/app -w /app "$django_image":"$django_tag" sh -c "\
    groupadd -g 1000 user && useradd -u 1000 -g 1000 -d /app/ user \
    && pip install Django~=$django_version \
    && django-admin startproject django_project . \
    && mkdir /app/django_project/static \
    && mkdir /app/django_project/media \
    && mkdir /app/django_project/template \
    && chown -R user:user /app/ \
    "

    # remove contianer
    docker container prune --filter label=type=django_builder -f

    # checking if the generation was succesfull
    if [ -f "./django/app/django_project/settings.py" ]; then
        # add custom django settings
        {
            echo ""
            echo "#custom settings"
            echo "from .settings_local import *"
        } >> ./django/app/django_project/settings.py
        cp ./django/settings_local.py ./django/app/django_project/

        # change variables set in env
        sed -i "s/^FROM .*/FROM $django_image:$django_tag/g" ./django/dockerfile
        sed -i "s/^POSTGRES_PASSWORD=.*/POSTGRES_PASSWORD=$(openssl rand -hex 32)/g" ./*/.env
        sed -i "s/^DJANGO_SECRET_KEY=.*/DJANGO_SECRET_KEY=$(openssl rand -hex 32)/g" ./django/.env
    fi

else
    echo "project already exists"
fi
