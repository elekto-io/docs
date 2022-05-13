---
title: "Installation"
linkTitle: "Installation"
weight: 2
description: >
  Full server installation documentation
---

This guide walks you through installing Elekto by hand on a server or VM.

# Installation Concepts

For Elekto to run in production, you need the following small application stack: 

* The Elekto python/flask/uWSGI application
* A backing SQL database instance
* A web proxy such as Nginx or Kubernetes Ingress
* A GitHub repository
* An Oauth authentication source

Elekto can be installed either as a native application or as a container.  The instructions below cover installation as a native application. For installation in a container, see [Kubernetes installation]({{< relref "kubernetes.md" >}})

## Installing Requirements and Python Binaries

Elekto is a Python/Flask/uWSGI application developed in Python 3. Building it from source requires the following prerequisites, which should be installed using your OS's packaging system:

* Python3 Pip and supporting build tools (like gcc), or Conda
* uWSGI server
* Database client libraries for your chosen database (see below)
* git

Having installed those prerequisites, you can now install the python requirements using Pip, which will build the python source:

```bash
# Installation with pip 
pip install -r requirements.txt

# Installation with Conda
conda env create -f environment.yml && conda activate elekto
```

Please check the above build process carefully for error messages; the only acceptable errors are (a) warnings about out-of-date versions and (b) missing database libraries for the databases you're not using.

It is possible that you could run Elekto using fastcgi instead of uWSGI, but at this time we have no documentation on how to do this.

## Backing SQL Database

Github stores ballots and some metadata in a designated SQL database, which is up to you to install and run.  Currently, Elekto supports the following:

* PostgreSQL
* MySQL (and its forks)
* SQLite

However, as Elekto uses SQLAlchemy, it can potentially support any SQL database that SQLAlchemy supports.  Adding new databases will require a PR to Elekto.  

Database requirements are very light, so it is completely feasible to run the database on the same server as the python application. The database server needs less than 2 CPUs, 1GB memory, and 25GB storage. You can also use a cloud database service; the included database support was chosen specifically because there are multiple cloud database services available.  In that case, you are likely to use the smallest size of cloud database available.

The Elekto database user needs to have permission to create tables. The database must be configured with user/password login.  Other forms of authentication are not yet supported.

Here's an example of doing this on PostgreSQL:

```
postgres=# create role elekto with login password 'TEST';
CREATE ROLE
postgres=# create database elekto owner elekto;
CREATE DATABASE
```

The Elekto application will not run if the database is unavailable. The ballot data contained in the database is not stored anywhere else, and as such is unrecoverable if the database is lost. For this reason, it is up to the administrator to set up and manage backups and high availability.  This is particularly a concern for SQLite, which is an embedded database; you will need to set up cron jobs on the server to back this up.

## Web Server

Elekto runs in the python uWSGI web application server.  uWSGI is not very scalable, though, and does not handle SSL connections.  As such, for anything other than developer mode, we recommend that you put a web server in front of it.

Nginx works well for this, whether as a standalone or as part of Kubernetes Ingress.  See the sample Nginx configuration in the installation directory of the Elekto repository for an example setup.  If running directly on a host with an Nginx proxy, you'll want to run Eletko in "socket" connection mode.  Other web servers would also work, but Nginx is the only sample configuration supplied.

On Kubernetes, you'll want to access Elekto via Ingress.  See `installation/deployment` for an example of this.  In a Kubernetes setup, you want to run Elekto in `http` mode. 

## GitHub Repository

Elekto's workflow is GitOps-based.  This means that to use Elekto, you must have a GitHub (GitLab TBD) repository for Elekto to attach to.  This must be a repository you own and have administration rights on, as you will be setting up a webhook and directories.

It does *not* need to be a repository that's exclusively dedicated to Elekto.  Most organizations using Elekto place its election metadata into a subdirectory of a repository that's used for other community documents (e.g. `knative/community/elections`).  Given that Elekto will refresh for every webhook push, however, it's probably better if it's not a repository that gets multiple commits per hour.

See [Configuration]({{< relref "configuration.md" >}}) for how to set up this GitHub repository, and the [Administration Guide]() for what files go into it.

## Oauth Authentication Source

Elekto does not maintain user authentication; by design, it relies on an outside Oauth source for user login.  Currently the only Oauth source supported is GitHub.  If you want to add other sources, contributions are very welcome.

See Configuration for how to configure this in GitHub.

## Other System Requirements

Elekto does not require elevated privileges to run, so for security, we recommend running it under an `elekto`, `www`, or `python` application account with restricted permissions.

Elekto caches a copy of the election respository on disk, and as such needs a file location to which it can write, with storage equal to the storage size of a git clone of that repository.

If you've completed everything in Installation, please proceed to [Configuration]({{< relref "configuration.md" >}}).
