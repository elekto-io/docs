# Elekto Documentation

Welcome to the source file repository for our documentation on [elekto.io](https://elekto.io/).

## Introduction 

The Elekto documenation website is built with [hugo](https://gohugo.io/) and currently uses [docsy](https://www.docsy.dev/) as its theme. 

## Run website locally

Clone this repo (or your fork) and its submodules by using --recurse-submodules option, run:

```bash
git clone --recurse-submodules https://github.com/elekto-io/docs.git
```

If you accidentally cloned this repository without `--recurse-submodules` flag, you can do the following to clone the submodules:

```bash
cd docs
git submodule init
git submodule update
cd themes/docsy
git submodule init
git submodule update
```

**[Optional]** If you want to write CSS/SCSS, you need to install `postcss-cli` and `autoprefixer`, run an `npm install` to install the dependencies from `package.json`. 

Finally, use hugo commands to start building up the site, run the following

```bash
# Start the server with live-reloading and with drafts
hugo -D server

# Start the server with live-reloading and without drafts
hugo server
```

## Running a container locally

You can run this website inside a [Docker](ihttps://docs.docker.com/)
container, the container runs with a volume bound to the `docs`
folder. This approach doesn't require you to install any dependencies other
than Docker.

Build the docker image 

```bash
docker build -f dev.Dockerfile -t elekto-docs:latest .  
```

Run the built image

```bash
docker run --publish 1313:1313 --detach --mount src="$(pwd)",target=/home/docsy/app,type=bind elekto-docs:latest 
```

Open your web browser and type `http://localhost:1313` in your navigation bar, This opens a local instance of the elekto documentation's homepage. You can now make changes to the docsy example and those changes will immediately show up in your browser after you save.

To stop the container, first identify the container ID with:

```bash
docker container ls
```

Take note of the hexadecimal string below the `CONTAINER ID` column, then stop
the container:

```bash
docker stop [container_id]
```

To delete the container run:

```
docker container rm [container_id]
```

## Deploy you changes

While the above section describes how the content is built locally, [https://elekto.io/](https://elekto.io/) is built and served by [github-pages]() on github.

Save your local changes by commiting them and then use the `deploy.sh` script to do the deployment.

```bash
./deploy.sh
```


## Contributing

We're excited that you're interested in contributing to the Elekto documentation! Check out the resources below to get started.

Checkout, [How to Contribute](CONTRIBUTING.md) for getting started on how to contribute and understanding the outlines the roles for Docs contributors.

## Getting Help

The elekto project is maintained by [Manish Sahani](https://github.com/kalkayan/) and [Josh Berkus](https://github.com/jberkus), Reach out to us one way or another.

## Support

Your help and feedback is always welcome!

If you find an issue let us know, either by clicking the Create Issue on any of the website pages, or by directly opening an issue [here](https://github.com/elekto-io/docs/issues/new) in the repo.
