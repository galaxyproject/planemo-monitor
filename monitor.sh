#!/bin/bash

planemo conda_init

sort -R $1 | while read repository subpath
do
   repo_dir=$(basename "$repository")
   git clone --depth=1 "$repository" "$repo_dir"
   planemo container_register --force_push --recursive "$repo_dir$subpath"
   rm -rf "$repo_dir"
done

