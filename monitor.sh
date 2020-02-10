#!/bin/bash

: ${PLANEMO_TARGET:="planemo==0.70.0"}

if [ ! -f .venv ]; then
    virtualenv .venv
    . .venv/bin/activate
    pip install -U pip
    pip install PyGithub
    git clone --depth=1 --recursive -b fix_registering_single_containers_with_different_suffix https://github.com/mvdbeek/planemo
    pip install planemo/ && rm -rf planemo/
fi

planemo conda_init

sort -R $1 | while read repository
do
   repo_dir=`basename "$repository"`
   git clone "$repository" "$repo_dir"
   planemo container_register --force_push --recursive "$repo_dir"
   rm -rf "$repo_dir"
done
