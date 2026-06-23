# Changelog Agent for Plaud Embedded SDK

Run this script for Claude Code to read changes in the **underlying SDK code** and **push a new branch with changelog updates**.

```bash
sh changelog-agent.sh
```

Note: You may need to run `chmod +x changelog-agent.sh` to make the script executable on first run

## Prerequisites

- [ ] GitHub ssh credentials configured
- [ ] Access to the Plaud docs repo and the Plaud Embedded SDK repo
- [ ] Claude Code authenticated

## How it works

1. Clones both the docs repo and the sdk repo in your working directory

2. Runs Claude Code headlessly with an instructions prompt

3. Commits the updates to a new branch and pushes to GitHub

4. Cleans up directories
