#!/bin/bash

clone_or_pull() {
    local repo_url="$1"
    local clone_dir="$2"

    if [ -d "$clone_dir" ]; then
        echo "Directory '$clone_dir' already exists. Pulling latest changes..."
        git -C "$clone_dir" pull
    else
        echo "Cloning into '$clone_dir'..."
        git clone "$repo_url" "$clone_dir"
    fi
}

clone_or_pull "git@github.com:Plaud-AI/plaud-dev-docs.git" "plaud-dev-docs"
clone_or_pull "git@github.com:Plaud-AI/plaud-embedded-skills.git" "plaud-embedded-skills"

claude -p "You are in a directory with two repos:\n 1. A mintlify docs repo: plaud-dev-docs \n2. A repo for agent skills: plaud-embedded-skills\n\nDo the following: \n1. Read the existing SKILL.md files and refrences to familiarize yourself with the current state of the Skill \n2. Verify all the referenced links in the Skill against the plaud-dev-docs repo, the \`docs.json\` file will be particularly useful. \n3. Verify any discrepancies between the docs and the Skill. **The docs are the source of truth** \n.4. Update the Skill with any updates from the docs" --allowedTools "Bash,Read,Edit" --permission-mode acceptEdits --output-format stream-json

BRANCH_NAME="update-$(uuidgen | tr '[:upper:]' '[:lower:]')"

git -C plaud-embedded-skills checkout -b "$BRANCH_NAME"
git -C plaud-embedded-skills commit -am "refresh-from-docs"
git -C plaud-embedded-skills push -u origin "$BRANCH_NAME"

rm -rf plaud-dev-docs plaud-embedded-skills
