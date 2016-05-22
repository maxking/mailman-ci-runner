#About this Repo

This is the docker image that is used to run ci-tests for mailman using
Gitlab-CI. We use `docker` system to run tests inside the containers built
from this image. For more information on how to use [gitlab-ci-multi-runner][1],
refer to [this][2] documentation.


## How to build?

To build this image run:

```bash
	$ docker build -t mailman-runner .
```

## Gitlab CI Multi Runner Config

This is the config (config.toml) used for the purpose of setting up the mailman-runner as a
docker-ssh service for running tests.

*Note: This is not a full config, only relevant parts are shown here. It is
recommended that you autogenerate the config using the `gitlab-ci-multi-runner register`
command and use values from this config.*

**This is outdated configuration**
```
[[runners]]
  name = "<the runner name>"
  url = "https://ci.gitlab.com"
  token = "<the gitlab-ci token>"
  executor = "docker"
  [services] 
```



[1]: https://gitlab.com/gitlab-org/gitlab-ci-multi-runner
[2]: https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/configuration/advanced-configuration.md
