# Simple and User-Friendly Dockerized Django Stack

## Purpose

This Docker stack aims to provide a foundational environment for Django development.

## How to Utilize

Feel free to customize all `.env` files according to your preferences.\
The passwords are automatically generated and thus require no manual changes.

1. Run the `init-project.sh` script to set up essential project data:

   ```bash
   ./init-project.sh
   ```

2. Launch Docker:

   ```bash
   docker-compose up
   ```

## Frequently Asked Questions

### How does the `init-project.sh` script function?

The script extracts necessary information from the `.env` files.\
Then, it initiates a Python container that installs Django.\
The resulting data is stored in the `./django/app/` folder.\
If files already exist in the folder, the script won't execute.

### Can I modify the Python and Django versions?

Yes, you can customize the Python and Django versions via the `.env` files.\
These settings only apply during the initialization process.

### Why are default values provided for the passwords in the env?

I've included placeholder values as they get overwritten during initialization.\
The database password and Django's secret key are automatically generated using "openssl rand -hex 32".

### Why implement a health check for the Postgres container?

A "health check" was necessary since the `depends_on` function didn't work smoothly with the Django container.\
Apparently, the Postgres image lacks an integrated health check.

### Can I integrate my own environment into your Docker template?

Unfortunately, I can't provide an exact specification as each installation varies.\
However, here are some considerations:

1. Overwrite the `requirements.txt` file.
2. Ensure the correct Python version is used.
3. Verify the Docker Compose file to confirm that volumes align with your installation.
