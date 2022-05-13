---
title: "Creating an Election"
linkTitle: "Creating"
weight: 2
description: >
  Guide for creating a new election in Elekto.
---

# The Election Directory

Create a new election in Elekto by creating a directory under the primary elections directory defined in the `ELECTION_DIR` [configuration variable](). What makes it an election directory or not is the presence of an `election.yaml` file; directories without this file will be ignored. This directory may be nested (e.g. `elections/2021/TOC`), but may not be nested under another election directory (one that has an `election.yaml` in it).

Anyone with appropriate permissions on the repository may create an election directory. Usually, creating the directory and file are the first actions of the selected Election Administrators.

Generally, after creating the directory, administrators create an `election.yaml`, `election_desc.md`, and `voters.yaml` file.  

## Election Administrators

Administrators are Elekto users who have special permissions to manage an individual election. Each election must have at least one, and can have any number although practically few elections require more than three. Administrators need not have any control of the underlying infrastructure, nor do they need rights on other elections. They need not even be qualified voters.

How election Administrators are selected is up to the organization running the election and its management of repository change permission.  As far as Elekto is concerned, the people listed in `election.yaml` are the Administrators regardless of how they got there.  Like Voters, Administrators log into Elekto with their OAuth IDs.

## The election.yaml File

This YAML file is the main file that creates and configures an election.  It contains multiple configuration variables, most of which can be changed at multiple times during the election. This file is required for the election to be recognized by Elekto, and if it has errors the election will not appear in the Elekto UI.

See the sample elections in [elekto.meta.test]() for examples of these files.

### election.yaml variables

**name**: Display name of the election. Required, changeable.

**organization**: Group for which this election is being run, for display purposes.  Required, changeable.

**start_datetime**: datetime that voting for the election starts, in UTC time.  At this datetime, the Vote button will be enabled automatically.  Required.  Changeable, but changing it after the election has already started can cause votes to be recorded or discarded improperly.

**end_datetime**: datetime that the election ends, in UTC time. At this time, the Vote button will be disabled automatically. Required.  Changeable until the election ends and a winner has been calculated, after which changes to this field will have no effect.

**no_winners**: number of potential winners in the election, for display to the administrators.  Required, changeable.

**allow_no_opinion**: True/False.  Can voters choose not to rank some candidates?  Required, changeable until the election begins, after which changes to this field may cause votes to be counted incorrectly.

**delete_after**: True/False, whether to delete the encrypted links between voters and ballots once election results are calculated.  Extra voter privacy measure.  Required, changeable until results are calculated.

**show_candidate_fields**: List.  A list of additional display fields for the candidate information pages.  Labels must match the candidate profile fields exactly, or the data will not be displayed.  Optional, changeable at any time.

**election_officers**: List of Oauth IDs of the election officers, determining who they are.  Required, changeable at any time.  Election officers need not be voters.

**eligibility**: Text to display in the "eligibility" section of the UI, for voter information. Optional, changeable at any time.

**exception_description**: Text to display before the Request Exception link. Optional, changeable at any time.

**exceptions_due**: Datetime (in UTC) when exception requests will no longer be accepted, and the Exceptions button will be disabled.  Can be any date before the end of the election. Required, changeable.  If your election does not allow voter exceptions, then set this to the date you create the election.

## The election_desc.md File

This file contains a Markdown-formatted description of the election for voter information purposes.  Since this information is displayed directly above the list of candidates and the voting controls, it's generally a good idea to limit it to about 1/3 page of text.  If you have more election details than that, consider summarizing and linking off to a page on your own website.

This description should include, at a minimum:

* A description of what's being decided in the election
* Who is hosting the election
* Contact information for questions

Ideally, it will also include:

* links to voter and candidate eligibility requirements
* link to candidate nomination process
* a short version of the election timeline

## The voters.yaml File

The voters file contains a list of Oauth IDs of the qualified voters for the election, as a simple yaml list.  If you wish to create an election before you have pulled the list of voters, then create an empty list until you add the voters.

Voters may be added at any time, until the end of the election.  Voters may also be removed at any time, but if a voter is removed from the file after they have already voted, their ballot will *not* be deleted. As such, if voters need to be removed after an election has begun, it's generally a good idea to abort the election and start a replacement one.

The contents of this file determine whether users see themselves as eligible to vote or not when they log into the UI.  Voters are not otherwise notified when their status changes.

## References

* [Elekto test elections]()
* [Kubernetes elections]()
* [Knative elections]()
