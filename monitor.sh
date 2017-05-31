#!/bin/bash

declare -a REPOSITORIES=(
    "https://github.com/galaxyproject/tools-iuc"
    "https://github.com/galaxyproject/tools-devteam"
)

: ${PLANEMO_TARGET:="https://github.com/jmchilton/planemo/archive/mulled_register.zip"}
: ${PLANEMO_OPTIONS:="--verbose"}

if [ ! -f .venv ]; then
    virtualenv .venv
    . .venv/bin/activate
    pip install -U pip
    pip install PyGithub
    pip install "${PLANEMO_TARGET}"
fi

planemo $PLANEMO_OPTIONS conda_init

for repository in "${REPOSITORIES[@]}"
do
   repo_dir=`basename "$repository"`
   git clone "$repository" "$repo_dir"
   planemo $PLANEMO_OPTIONS container_register --recursive "$repo_dir"
   rm -rf "$repo_dir"
done
