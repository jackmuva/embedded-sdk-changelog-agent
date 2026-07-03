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
clone_or_pull "git@github.com:Plaud-AI/tb-plaud-mobile.git" "tb-plaud-mobile"

claude -p "You are in a directory with two repos:\n 1. A mintlify docs repo: plaud-dev-docs \n2. A mobile SDK repo: tb-plaud-mobile \nDo the following: \n1. Read plaud-dev-docs/plaud-embedded/changelog.mdx for the last update date \n2. Look at the commit history for tb-plaud-mobile and focus on updates since the last changelog date (use \`git -C tb-plaud-mobile\` to set working directory when using \`git log\`) \n3. Update plaud-dev-docs/plaud-embedded/changelog.mdx.\n\n Some guidelines for the changelog: \n* Do not include bug information \n* Match the existing style of changelog.mdx \n* Only include larger features/news that users will care about" --allowedTools "Bash,Read,Edit" --permission-mode acceptEdits --output-format stream-json --verbose

BRANCH_NAME="changelog-$(uuidgen | tr '[:upper:]' '[:lower:]')"

git -C plaud-dev-docs checkout -b "$BRANCH_NAME"
git -C plaud-dev-docs commit -am "changelog update"
git -C plaud-dev-docs push -u origin "$BRANCH_NAME"

rm -rf plaud-dev-docs tb-plaud-mobile
