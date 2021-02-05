---
title: "Overview"
linkTitle: "Overview"
weight: 1
description: >
  Understand the working of elekto.
---

The application requires a [meta]() repository to store election meta files. The meta repository is the single source of truth for the application and is managed by gitops, all the tasks like creating an election, adding/removing voters to the list are managed by raising specific pull requests in the meta repository. See our detailed instruction [docs](/docs/README.md)

![architecture.png](arch.png)
