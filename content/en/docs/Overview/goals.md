---
title: "Design Goals"
linkTitle: "Goals"
weight: 1
description: >
  Reasons behind the Elekto design
---

Elekto was originally built to support the [Kubernetes Steering Committee elections](https://github.com/kubernetes/steering/blob/master/elections.md), supporting the existing workflow of that community.  It's also intended to avoid several chronic issues with usage of the [CIVS election system](https://civs1.civs.us/).

Before adopting, or contributing to Elekto, please read these principles as they give you a broad idea of what kinds of features and changes the project is interested in or likely to implement.

## Preference Elections for Small Organizations

Elekto is designed only to support "preference elections" where voters rank candidates.  We have found preference elections to offer better outcomes than other methods, such as plurality.

Currently, only the Condorcet preference election algorithm is supported, but contributions of other preference election accounting methods would be very welcome.

Elekto is not designed to support public governmental elections, or any election that might attract either thousands of voters, or a determined effort to compromise the system.

## Simplicity

The project is designed to be an extremely simple, lightweight web application.  Simplicity makes it easy to install and support in a variety of environments and platforms. This means that organizations can run Elekto as a microservice, on their own, instead of requiring a paid, hosted service.

Simplicity also makes Elekto easy to fork and modify, as well as contribute to.  We chose [Flask](https://flask.palletsprojects.com/en/2.0.x/) as our framework with this in mind.  It's also why our container image is a simple, unified image.

This does mean that changes that would substantially increase the complexity of Elekto -- such as a theme engine or porting it to Django or decomposing it into a half-dozen scalable subservices -- are unlikely to be accepted in the main project.

## No Email

Elekto does not send any email, or other types of messages, to anyone.  100% of Elekto interaction is via GitOps and the Web UI.

This requirement is based on experience with other election systems.  Email today is a singularly unreliable way to deliver ballots or other election messages, and other channels aren't much better.  Anyone who has administered an election under CIVS can tell you that 80% of their work is troubleshooting email delivery issues.

## Microservice

Elekto is intended to be run as a microservice, with one Elekto instance per organization or team.  It is not intended to run as a multi-tenant service; instead, run a separate Elekto instance for each user.

Each Elekto instance connects to only one metadata repository, one database, and one Oauth source.  Again, if you need multiple configurations, the solution is to run multiple Elekto instances.

Elekto supports any number of elections for that one organization.

## GitOps Administration

The practice of defining adminstrator actions and application configuration via changes to files in a Git repository is called "GitOps".  Elekto administration is based entirely on GitOps, which offers the following advantages:

* Eliminates multiple webforms, keeping the codebase smaller
* Allows organizations to define their change and approval workflow through their git repo, including owner roles and multi-stage approval and revision
* Provides a transparent, long-term historical record of any and all election setup changes
* Unifies documentation and configuration
* Reduces dependency on database hosting

As such, the only data in Elekto that does not live in a git repo is data that needs to be private/secret: ballots, raw election results, and exception requests.

## Transparency

Elekto is aimed at public open source projects, which means that complete transparency of all election steps is required and provided.  As such, the metadata git repo and the Elekto instance are expected to be publicly readable, and no provisions have been made for running Elekto using private repos or webservers on closed networks.  

Transparency is also carried out in other design decisions. For example, while only designated voters can vote in an election, any user (or any authenticated visitor) can view the details of any election.

## Secret Ballot

Voters must be able to vote without their individual ballots being easily snoopable, whether by other voters, election officers, or infrastructure staff.  In a small organization, infra maintainers and officers are usually voters and sometimes candidates themselves, and as such ballot identity needs to be hidden even from someone with direct access to the database.

Elekto was also built with the secondary requirement of allowing voters to re-cast their ballots up until the election deadline.  However, individual ballot auditablilty was not a requirement, so it is not yet implemented (contributions welcome).  Aggregate ballot auditablity is incompatible with secrecy, and as such is out of scope.
