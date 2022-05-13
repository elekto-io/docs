---
title: "Running an Election"
linkTitle: "Running"
weight: 2
description: >
  Guide for running an election in Elekto.
---

An Elekto election includes a pre-election phase and an voting phase.  Depending on your actual election process, the pre-election phase may be unnecessary or handled entirely outside Elekto.  If so, ignore the pre-election phase instructions below.

## A Note on Notifications

Elekto does not send notifications via email or other messaging to anyone.  As such, it is up to your election administrators or officers to send out notifications using your normal community channels.  All community members can check their current status and the status of the election at any time using the web UI,  but they will not receive messages or reminders.  

As such, when this Guide talks about sending reminders or notices, it is talking about action by the Election Officers or other community members.

## Pre-election Phase

Two things happen between the time the election is announced and the time that voting starts.  One is adding voters and acting on exceptions, and the second is adding nominated candidates.

The pre-election phase begins when the election is created in Elekto, and ends when voting starts.

### Managing Voters

Voters are added to an election by populating [the `voters.yaml` file](). Obtaining a list of voters is up to you and your organization, as different groups have vastly different eligibility processes.  Many CNCF projects obtain a list of voters by filing a ticket requesting a data pull from DevStats, CNCF's contributor metrics system.

Once you have obtained a list of qualified voters and added them to `voters.yaml`, you should use your organization's communications channels to announce that voters can [now verify their status](). Voters will be able to log into Elekto and check whether they are Eligible or not via the UI.  If they find they are ineligible, they can request an exception (see below).

Until the election starts, you can freely add and remove voters from `voters.yaml` as your election rules dictate.  We recommend that voters be sorted alphanumerically to make editing the list of voters easier.  Elekto will ignore YAML comments, sort order, and even duplicates in the file. 

#### Voter Exceptions

Organizations may allow people to challenge their voter ineligibility.  Sometimes this is because the voter list process is error-prone, or it can be because some voter criteria are difficult to measure empirically. Based on the Kubernetes project, the term for requesting a ballot when the original voter list did not allow an individual to vote is a "voter exception".

If your voter exception requests are public, then they can be handled via pull requests against the voter list.  However, in Kubernetes and other projects, the exception requests are confidential, in order to spare members from embarrassment if their request is declined.  For this reason, Elekto provides a mechanism for potential voters to request an exception through the UI.

The list of exceptions is available via the Admin screen in the UI.  Access it by clicking the Admin button in the Election Information screen, which should be visible if you are an election officer and logged in.

![photo of admin screen with several exception requests]()

From here you can see the list of requests.  To keep track of which ones you have taken action on, you can click the button to indicate that the requests have been reviewed.  This UI does not add voters whose exception requests are granted, however.  To make voters eligible, you will need to modify the `voters.yaml` file in the repository.  The requests screen is for tracking only.

### Adding Nominated Candidates

Candidates get added to the Elekto system when they have completed and merged profiles.  All profiles will need to be merged before the election begins.  How candidates are nominated and qualified and their profiles are reviewed is entirely up to your organization; Elekto cares only that the candidate.md file has the correct formatting and naming.

To support this, it's usually helpful for the Election Officers to create a `nomination-template.md` file as a template for potential candidates to copy.  EOs are are usually also in charge of helping candidates with completing their profiles and sending out reminders to the community about nomination deadlines.

For more about candidate profiles, see the [Candidate Guide]().

## Voting Phase

At the date and time indicated in the `start_datetime` setting, voters will be able to start voting. No further administrative action is required.  During the voting phase, administrators should have little to do other than adding people to the voters list from the Exceptions.

### The Administrator Console


 
### Changing the Voters List While Voting

Most organizations continue to accept Voter Exception requests during the voting phase, so that voters can be added and cast ballots even if they are slow to check their status.  Closing exceptions about three days before voting ends can be a good timeline.  

There is no problem adding voters at any time before the `end_datetime` of the election.  Once additional voters are merged into `voters.yaml`, they are immediately able to vote.  

Removing voters from the list, however, is a bad idea once voting has started.  Once a voter has cast a ballot, there is no way to delete their ballot.  While administrators can check whether a particular voter has voted, deleting a voter can be subject to a race condition. That said, problems with duplicate voter IDs (e.g. one voter with two Github accounts) can be cleared up by deleting accounts during voting if you have the active cooperation of the voter.

### Modifying the Election While Voting

Administrators can make changes to `election.yaml` and other settings during the election.  Not all such changes are effective or wise, however.  What follows are some notes on settings it makes sense to change during the voting phase.  Settings that are not mentioned should not be changed. Elekto provides no guardrails here, though; administrators are technically able to change anything they wish.

* `election_desc.md`, `eligibility`, `exception_description`: descriptive fields can be changed any number of times without worry.
* `end_datetime`: you can change the end time of the election in order to give more time for voting as long as the election has not yet been concluded.
* `exceptions_due`: you can also extend the Exceptions deadline until the election concludes.
* `no_winners`, `discard_after`: these fields affect election conclusion, so they can be changed until then.
* `election_officers`: officers can be added and removed from the election during voting.

You may also make changes and updates to candidate profiles during voting.  However, adding or removing a candidate during voting would make it impossible to correctly compute the ballots.  As such, if you need to change the list of candidates after voting starts, you will need to halt the election and hold a new one.

### Retrieving and Canceling Ballots

During voting, voters may cancel and recast their ballot.  Adminstrators, however, have no mechanism to cancel any voter ballot, or assist voters who have forgotten their passphrase.  This is intentional, in order to prevent Election Officers from manipulating the election.
