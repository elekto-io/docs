---
title: "Upgrading Elekto"
linkTitle: "Upgrading"
weight: 7
description: >
  How to upgrade Elekto
---

# Upgrading

In most cases, you should be able to upgrade Elekto just by replacing the 
Python/Flask code or the container image and restarting the service.
The cases where that is not true are documented below.

If you are running Elekto as Python code, you should also update the
dependencies every time you upgrade, as we usually upgrade python library 
versions to current ones.

```
pip3 install -r requirements.txt
```

## Upgrading from 0.5 to 0.6

**This Upgrade Requires Extra Steps**

Version 0.6 involves several major changes to the database schema which require 
a multi-step database migration.  **At this time, this process is only automated
for PostgreSQL**.

**The Elekto Project Recommends Backing Up Your Database Before Upgrading**

For users on PostgreSQL, the process should be as simple as:

1. Shut the Elekto web application down
2. Upgrade Elekto software
3. Run `python console --migrate`

If you are using the official container image, or others built like it, then
the container image should automatically do the above when you delete and replace
the container or pod.

This may fail on PostgreSQL, either because you have modified your database schema
after creation by Elekto, or because the Elekto database user does not have 
permissions to modify tables.  In either case, you may need to run the 
database migration manually.  If so, you will need to run the following SQL
statements as the database owner or superuser:

```
CREATE TABLE schema_version ( version INT PRIMARY KEY );
INSERT INTO schema_version VALUES ( 2 );
ALTER TABLE voter ADD COLUMN salt BYTEA, ADD COLUMN ballot_id BYTEA;
CREATE INDEX voter_election_id ON voter(election_id);
ALTER TABLE ballot DROP COLUMN created_at, DROP COLUMN updated_at;
ALTER TABLE ballot DROP CONSTRAINT ballot_pkey;
ALTER TABLE ballot ALTER COLUMN id TYPE CHAR(32) USING to_char(id , 'FM00000000000000000000000000000000');
ALTER TABLE ballot ALTER COLUMN id DROP DEFAULT;
ALTER TABLE ballot ADD CONSTRAINT ballot_pkey PRIMARY KEY ( id );
CREATE INDEX ballot_election_id ON ballot(election_id);
```

We [do not yet have instructions](https://github.com/elekto-io/elekto/issues/67) for upgrading MySQL or SQLite.  Those are in development.
If you have an Elekto/MySQL instance, please contact us via Elekto slack channel
on CNCF Slack, or by [commenting on the issue](https://github.com/elekto-io/elekto/issues/67); we would like to work with you on this.

If you do not care about preserving election history, your other option is 
to simply delete the old database and create a new, empty one.  In that case,
Elekto will generate a new, updated schema through `console --migrate`.
