---
title: "Candidate Guide"
linkTitle: "Candidates"
weight: 2
description: >
  Guide for candidates participating in an Elekto election
---

## Your Candidate Profile

Your organization will have some type of nomination and confirmation process for how you become a candidate for election.  From Elekto's perspective, though, it's much simpler.  You are a candidate if you have a candidate profile file. The rest of this guide is therefore details on what needs to be in that file.

### Creating a Candidate File

Usually your Election Officers will create a template file for you to copy and create your file.  Your first step is to create a copy of this file with the following naming scheme:

`candidate-youridhere.md`

The filename must start with `candidate-` to be recognized as a candidate file.  The second half of the filename should match the `ID` field inside the candidate file, including case. If the names do not match, then the file will not be recognized as a candidate.

### Contents of the Candidate File

Each candidate file is a markdown file with a small YAML header.  Here's a sample candidate file:

```
-------------------------------------------------------------
name: elekto
ID: elekto
info:
- Language: Esperanto
-------------------------------------------------------------

## Reason for Name

"elekto" is "election" (or selection, or appointment) in the academic language Esperanto.  Also, it sounds like the name of a C-list superhero.

## Availability Search

Nobody currently seems to have trademarks on the name in the USA.  Various domains are available, as is the Github namespace.
```

The YAML header contains several fields to be filled in by the candidate:

* name: the candidate's name to be displayed in the UI
* ID: the unique candidate ID.  Usually this is their OauthID, but it can be any arbitrary string as long as it is unique for that election.  It also needs to match the second half of the filename.
* info: a list of key-value pairs that should match the show_candidate_fields 
