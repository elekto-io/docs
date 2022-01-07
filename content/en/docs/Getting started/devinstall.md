---
title: "Development Installation"
linkTitle: "Development Installation"
weight: 1
description: >
  Create a dev install on your laptop
---

This guide will help you create a development installation of Elekto on your laptop, for hacking and testing purposes.

## Create a development environment

The application is written in Python using Flask and SQLAlchemy. This repository ships a `requirements.txt` and an `environment.yml` for conda users.

```bash
# Installation with pip 
pip install -r requirements.txt

# Installation with Conda
conda env create -f environment.yml && conda activate elekto
```

## Setup env variables

The repository has a `.env.example` file which can be used as a template for `.env` file, update the environment file after copying from `.env.example`.

```bash
# create a new .env file from .env.example
cp .env.example .env
```

Set the basic information about the application in the upper section
```bash
APP_NAME=k8s.elections     # set the name of the application
APP_ENV=development        # development | production   
APP_KEY=                   # random secret key (!! important !!)
APP_DEBUG=True             # True | False (production)
APP_URL=http://localhost   # Url where the application is hosted
APP_PORT=5000              # Default Running port for development 
APP_HOST=localhost         # Default Host for developmemt 
```

Update the database credentials, 
```bash
DB_CONNECTION=mysql        # Mysql is only supported 
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=name          
DB_USERNAME=user
DB_PASSWORD=password
```

Update the meta repository info
```bash
META_REPO=https://github.com/elekto-io/elekto.meta.test.git
META_DEPLOYMENT=local
META_PATH=meta
META_BRANCH=main
META_SECRET=db5a951969c379e75d0bf15ad6ff8b4a36fbeb02  # same as webhook of the same meta repository
```

Update the Oauth info, create a GitHub Oauth app if already not created.

```bash
GITHUB_REDIRECT=/oauth/github/callback
GITHUB_CLIENT_ID=d79f002c1d2e3cf20521
GITHUB_CLIENT_SECRET=2f64fff6612c46f87314ad5bb81d05c8fd29c561
```

#### Migrate and Sync DB with Meta

The `console` script in the repository is used to perform all the table creations and syncing of the meta files. 

```bash
# to migrate the database from the command line 
python console --migrate 
```

To sync the database with the meta files 

```bash
# to the sync the database with the meta
python console --sync
```

#### Run the application Server locally 

The flask server will start on `5000` by default but can be changed using `--port` option.

```bash
# to run the server on default configs
python console --run

# to change host and port
python console --port 8080 --host 0.0.0.0 --run
```
