#!/bin/sh

PLANEMO_OPTIONS="--verbose"
git clone https://github.com/galaxyproject/tools-iuc
planemo $PLANEMO_OPTIONS container_register tools-iuc
