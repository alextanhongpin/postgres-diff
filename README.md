# go-diff-migrations

Testing out [migra](https://databaseci.com/docs/migra/quickstart) for alternative of running migrations.



Instead of using version migrations file, we only keep the final schemas for the database. The diff between the current and expected schemas will then produce the statements for the changes.

Some advantages over versioned migrations:
- no longer need to keep a long list of versioned migrations (especially when working in a large team)
- no out-of-order migrations issue
- schemas are more declarative
- the commit history can be diffed to produce back the statements

Disadvantages:
- more complexity in setting up CI for this
- changes can be overwritten when working in teams in different branches
