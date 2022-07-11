---
title: "Administration"
linkTitle: "Administration"
weight: 2
description: >
  Guide for running elections using Elekto.
---

Administering elections in Elekto is done through pushes of structured files to a GitHub repository.  See the [configuration guide]({{< ref "/docs/Setup/configuration.md" >}}) for how to configure the link to the repository.  This guide outlines how the Election Administrators run an individual election.  There are three parts to this:

1. [Creating an election]({{< relref "creating.md" >}})
2. [Running an election]({{< relref "running.md" >}})
3. [Concluding an election]({{< relref "concluding.md" >}})

## GitOps and Administration

All Administrative actions happen through a single GitHub repository, or via the Elekto web application.  As such, any references to files or directories in this Guide are references to files and directories under the chosen repository.

For that matter, "administrator actions" in general usually refers to merging files or changes into the designated git repository and branch.  Only two actions take place in the Elekto UI: reviewing voter exceptions and calculating election results.  Everything else happens because an admin changed something in a file and that change was merged.

This means that it is up to your organization to enforce correct permissions and process for the repository and its directories so that administrators can merge what they're supposed to be able to merge (and not what they're not, like someone else's election).  Ideally, your project's CICD workflow will support this.
