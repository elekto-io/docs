
---
title: "Elekto Documentation"
linkTitle: "Documentation"
weight: 20
menu:
  main:
    weight: 20
---

Elekto is an open-source software for securely conducting election. Elekto was inspired by the long-running [CIVS project](https://github.com/andrewcmyers/civs) and built to conduct kubernetes steering and community elections. The project is hosted and maintained by CNCF.

> *If you have reached here trying to vote in an online election, you are in the wrong place.*

Elekto was designed to support the following:
- 100% [GitOps](https://about.gitlab.com/topics/gitops/) workflow for configuration and election administration
- 100% Oauth-driven workflow for voters (no emails)
- Preference election voting (starting with Condorcet)
- Multiple elections for the same organization
- Responsive web design
- Secret ballot voting