---
title: "Configuration"
linkTitle: "Configuration"
weight: 2
description: >
  Setting up and configuring Elekto for operation
---

# Configuration and Setup

Elekto's configuration is divided into three parts:

1. Oauth and GitHub configuration
2. Runtime environment
3. Per-election configuration

This document covers the first two, which consists of the items that need to be configured before Elekto will run.  The third part is covered in the [Administrator Guide].

## Oauth and Repository Configuration

Elekto relies on an external Oauth provider for user authentication, by design.  This provider must be configured to accept authentication requests from Elekto.  You may only have one Oauth provider per Elekto instance, as authentication happens before selecting an election.

You must also configure the repository that contains the election metadata (hereafter "the repo") to push changes to Elekto.  

Currently, the only Oauth provider offered is GitHub.  Contributions of additional providers are extremely welcome.

### GitHub Setup

#### GitHub Oauth

You must set up an "Oauth Application" that Elekto can use.  In GitHub, this is under Settings-->Developer Tools-->Oauth Applications.  Note that Oauth Apps are belong to *accounts* rather than organizations, so you'll want to set up an account with shared access in your infra team. We also recommend setting up a separate Oauth App for Elekto rather than re-using one created for other purposes, and giving each Elekto instance its own secret key.

The Oauth App must have the following settings:

* Application Name: whatever you've named your Elekto instance
* Homepage URL: the url of your Elekto instance
* Authorization Callback URL: https://your.elekto.domain/oauth/github/callback  (note that this can be changed in ENV)

Once you create the Oauth App, GitHub will create a ClientID for it, which you populate in GITHUB_CLIENT_ID in ENV.  You then create a new Oauth secret under the app and copy the value for that, and that gets populated in GITHUB_CLIENT_SECRET.

#### GitHub Repository Webhook

In order to receive changes from the repo, you need to add a webhook that pushes changes whenever you merge.  Webhooks are under "settings" for the individual repository (which also means you must be a repo onwer).  

The Webhook should have the following settings:

* Payload URL: https://your.election.domain/v1/webhooks/meta/sync
* Content Type: application/json
* Shared Secret set to the same as META_SECRET
* Enable SSL Verification
* Just The Push Event
* Check "Active" to turn it on

This "secret" is an arbitrary string that authenticates the push to the Elekto server.  It can be any string, such as one created by a password generator or a passphrase you like.  This string then gets set in META_SECRET. 

## The Environment File

Elekto is designed to accept its runtime configuration as ENV variables in its shell environment.  A sample `.env.example` file can be found in the base directory of the Elekto source.  These ENV configuration variables are not expected to change frequently, or at all, for any particular running Elekto instance.  Changing them generally requires restarting Elekto.

All of these env variables need to be set before starting Elekto as a uwsgi application, or even in developer mode; without them, Elekto will error out and refuse to start. You can set this up however you please:

* as the `.bashrc` for the elekto application user
* as ENV variables for a container running Elekto
* preloaded in a systemd unit file
* injected through a ConfigMap and a Secret into an Kubernetes pod

Since we use ENV for Elekto configuration, this does mean that Elekto must be launched under a shell.

### ENV Variables

What follows are the ENV variables that must be set for Elekto to run.  

#### Application Information

**APP_NAME**

*Required* Name of the Elekto instance you are running.  Displays in some parts of the UI.  For user information only.

Example: `k8s.elections`

**APP_ENV**

*Optional* Status of this Elekto instance, for CI/CD purposes.  Not used internally by Elekto.

Example: `production` or `development` 

**APP_KEY**

*Optional* Seed string for Flask encryption if running Flask in standalone mode.  Not required if fronting with an HTTPS webserver.

Example: ``

FIXME

**APP_DEBUG**

*Required* Whether to run in Debug mode for troubleshooting purposes.  In Debug mode, will output stack traces for errors and reload templates.

Example: `True` or `False`

**APP_URL**

*Optional* URL of the Elekto instance.  Used by some uwsgi and/or Nginx configurations.  Not used internally by Elekto.

Example: `http://elections.knative.dev`

**APP_PORT**

*Optional* Used in some uwsgi start scripts, and when running Flask in standalone mode.  Port on which to serve Elekto.

Example: `5000`

**APP_HOST**

*Optional* Used in some webserver startup scripts, and by the Flask server in standalone mode.  Name of the host served by this Elekto instance.

Example: `localhost`

**APP_CONNECT**

*Optional* Whether to serve uwsgi over HTTP or via a local unix socket.  Used by some startup scripts; see `entrypoint.sh` for an example.  

Example: `http` or `socket`

#### Database Connection

**DB_CONNECTION**

*Required* Which database connection type to use.  Currently only postgresql, mysql, and sqlite are supported.  

Example: `postgresql`, `mysql`, or `sqlite`

**DB_HOST**

*Required* The URL, IP, or hostname of the database server.  Ignored if using SQLite (set to `N/A`).

Example: `pgdb-1a.prod.elekto.dev`

**DB_PORT**

*Required* The network port for the database server.  Ignored if using SQLite (set to `1001`).

Example: `3306`

**DB_PATH**

*Optional* Used only for SQLite.  Path to the database filesystem.

Example: `/var/db/elekto-db`

**DB_USERNAME**

*Required* Login user for the Elekto database.  Not used by SQLite.

Example: `elekto`

**DB_PASSWORD**

*Required* Authentication password for the Elekto database.  Not used by SQLite.

Example: `1a6e4b3f55dc`

#### Repository Configuration

**META_REPO**

*Required* GIT clone URL for the repository which contains the election configurations.  Should be the `.git` link, not the `.html` one.

Example: `https://github.com/kalkayan/k8s.elections.meta.git`

**ELECTION_DIR**

*Required* Directory, relative to the Git repository root, containing the set of election subdirectories. Must be a parent directory. Can be an arbitrarily deep path.  Do not use a leading or trailing `/`.

Example: `elections`, `gov/steering/elections`

**META_DEPLOYMENT**

*Optional* Reserved for future advanced configuration use.

Example: `local`, `sidecar`

**META_PATH**

*Required* Local file location at which to store a clone of the election data repository.  This directory will be created by Elekto at sync time, so the application must have the ability to write to the parent directory.  May be absolute or relative; if relative, will be under the eletko source directory.  Defaults to `meta`.  For containers, a directory under `/tmp` is recommended to make sure the location is writeable.

Example: `meta`, `/tmp/meta`

**META_BRANCH**

*Required* Which git branch has the merged version of the election data.  Defaults to `main`.

Example: `main`, `master`, `prod`

**META_SECRET**

*Required* The shared secret string used in the Github webhook for updates of the election data repository.  Can be set to anything you like; we recommend a random md5 string or generated password.

Example: `92a488d11c0d27bbfea0a97e3332e08a` 

#### Oauth Settings

At this time, there are only settings available for GitHub because other Oauth sources haven't been implemented.  When other sources get added to Elekto, each will get their own configuration variables.

**GITHUB_REDIRECT**

*Required* Flask path for the GitHub authentication callback.  Defaults to `/oauth/github/callback`, and there's no good reason to change it.

Example: `/oauth/github/callback`

**GITHUB_CLIENT_ID**

*Required* The Client ID from the GitHub Oauth Application.

Example: `0b9138c0b2ffeefd9fc1`

**GITHUB_CLIENT_SECRET**

*Required* The Client Secret from the GitHub Oauth Application.

Example: `dd37278f8e9d57571590ad9288f0aae62228c2e8`
