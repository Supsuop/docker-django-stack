#!/bin/sh

python manage.py migrate --noinput
python manage.py collectstatic --noinput --clear
exec gunicorn django_project.wsgi:application --bind 0.0.0.0:8000
