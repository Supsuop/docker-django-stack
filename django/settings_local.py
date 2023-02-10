from getenv import env
import os

ALLOWED_HOSTS = env("DJANGO_ALLOWED_HOSTS")
SECRET_KEY=env("DJANGO_SECRET_KEY")
DEBUG = env("DJANGO_DEBUG")
DATABASES = {
    'default': {
        'ENGINE': env("DB_ENGINE"),
        'NAME': env("POSTGRES_DB"),
        'USER': env("POSTGRES_USER"),
        'PASSWORD': env("POSTGRES_PASSWORD"),
        'HOST': env("DB_HOST"),
        'PORT': env("DB_PORT"),
    }
}

BASE_DIR = os.path.dirname(os.path.realpath(__file__))

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'static')

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
