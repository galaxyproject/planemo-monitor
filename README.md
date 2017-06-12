[![Build Status](https://travis-ci.org/galaxyproject/planemo-monitor.svg?branch=master)](https://travis-ci.org/galaxyproject/planemo-monitor)

# Planemo Monitor

This repository monitors repositories containing Galaxy and CWL tools and opens requests to
https://github.com/jmchilton/multi-package-containers to register mulled containers for combinations
of requirements that are not already published or registered. The result of this is that these
tools will have containers published and available on quay.io.

## Adding Your Repository

Feel free to open a pull request to add your repository to the list in monitor.sh to monitor
your tools published to Github as well.

## Implmentation

See .travis.yml for the driving recipe and monitor.sh for the Planemo driving script. monitor.sh
is meant to be executed as a cron job - it will clone each repository tracked and walk all
available tools using Planemo. For each tool it will check its requirements and for each combination
of requirements in such tools and ensure that this combination of requirements is registered in
https://github.com/jmchilton/multireqcontainers or that there is an open request already. To perform
this registeration - planemo simply opens a pull request adding a hashed file to that repository -
once merged the CI associated with multireqcontainers will build and publish that container to
quay.io.

## Future Enhancements

- This repository repository only deals with tools that require multiple requirements since all
  single Bioconda requirements should already be available on http://quay.io/biocontainers -
  but we should have a mechanism for capturing single requirements from other best practice channels
  such as conda-forge and publishing those.
- Metadata about tools requiring these repositories should be stored in the multireqcontainers
  repository.
- The containers should be tested using both the tools and the Conda recipe tests after they
  are constructed.
- We should be publishing a report (maybe just a visualizable XUnit description) or available
  requirements and containers for each repository.
