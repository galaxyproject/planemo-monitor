#!/bin/bash

declare -a REPOSITORIES=(
    "https://github.com/galaxyproject/tools-iuc"
    "https://github.com/galaxyproject/tools-devteam"
)

PLANEMO_OPTIONS="--verbose"

for repository in "${REPOSITORIES[@]}"
do
   repo_dir=`basename "$repository"`
   git clone "$repository" "$repo_dir"
   planemo $PLANEMO_OPTIONS container_register --recursive "$repo_dir"
   rm -rf "$repo_dir"
done
