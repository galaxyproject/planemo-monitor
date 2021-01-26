#!/bin/bash

: ${PLANEMO_TARGET:="planemo==0.74.1"}

if [ ! -f .venv ]; then
    virtualenv .venv
    . .venv/bin/activate
    pip install -U pip
    pip install PyGithub
    git clone --recursive -b fix_container_register_for_gh_workflow https://github.com/mvdbeek/planemo && pip install planemo/
    # pip install "$PLANEMO_TARGET"
fi

planemo conda_init

sort -R $1 | while read repository
do
   repo_dir=$(basename "$repository")
   git clone --depth=1 "$repository" "$repo_dir"
   planemo container_register --force_push --recursive "$repo_dir"
   rm -rf "$repo_dir"
done
