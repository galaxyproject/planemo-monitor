# Planemo Monitor

This repository monitors repositories containing [Galaxy](https://galaxyproject.org/) and CWL tools and opens requests to
https://github.com/BioContainers/multi-package-containers to register mulled containers for combinations
of requirements that are not already published or registered. The result of this is that these
tools will have containers published and available on quay.io.

## Adding Your Repository

Feel free to open a pull request to add your repository to the list in `repositories.list` to monitor
your tools published tn GitHub as well.

## Implementation

See [monitor.yaml](https://github.com/galaxyproject/planemo-monitor/blob/master/.github/workflows/monitor.yaml) for the driving recipe and [monitor.sh](https://github.com/galaxyproject/planemo-monitor/blob/master/monitor.sh) for the Planemo driving script. monitor.sh
is meant to be executed as a cron job - it will clone each repository tracked and walk all
available tools using Planemo. For each tool it will check its requirements and for each combination
of requirements in such tools and ensure that this combination of requirements is registered in
https://github.com/jmchilton/multi-package-containers or that there is an open request already. To perform
this registeration - planemo simply opens a pull request adding a hashed file to that repository -
once merged the CI associated with multi-package-containers will build and publish that container to
[quay.io](https://quay.io).

## Future Enhancements

- This repository repository only deals with tools that require multiple requirements since all
  single Bioconda requirements should already be available on https://quay.io/organization/biocontainers -
  but we should have a mechanism for capturing single requirements from other best practice channels
  such as conda-forge and publishing those.
- Metadata about tools requiring these repositories should be stored in the multireqcontainers
  repository.
- The containers should be tested using both the tools and the Conda recipe tests after they
  are constructed.
- We should be publishing a report (maybe just a visualizable XUnit description) or available
  requirements and containers for each repository.

