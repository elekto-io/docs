---
title: "Concluding an Election"
linkTitle: "Concluding"
weight: 2
description: >
  Guide for finishing an election in Elekto.
---

## Completing the Election

Once the end date for the election is past, it is time for the Election Officers to conclude the election.  This has two steps: computing the candidate rankings, and publishing the election results.

### Computing the Rankings

After the `end_datetime`, Election Officers will be presented with a button on the Administrator Console to compute the election rankings.

![Administrator console with compute winners button]()

Clicking that button does two things.  First, it calculates the preference election mathematical results according to the configured election method, displays those results, and saves them to the database.  Second, if `delete_after` is set, it deletes all of the encrypted links between voters and ballots as an additional privacy measure.

![Administrator console with election results]()

Once the election is calculated, it may not be "re-opened" by extending the end date.

### Publishing the Results

The candidate rankings computed by Elekto are absolute mathematical rankings, and do not take into account organizational rules such as employer, role, or diversity quotas in the elected body. Some organizations also require the election to be certified by another committee. As such, the raw election results are visible only to the Election Officers.

To share the election results with all voters, create a `results.md` file.  This is a simple, markdown-formatted file with no special headers.  You add text in it to share the election results according to the rules of your organization.

![example election results screen]()

### What about Tie Votes?

In a preference election, two candidates with an identical ranking result in a tie.  While Elekto uses special algorithms to prevent tie votes (such as, but default, Schultze), certain combinations of ballots result in an unbreakable tie, particularly in elections with low numbers of ballots.

In the case of a tie, it is up to your election rules to decide how to handle it.  Usually, this means a runoff election.
