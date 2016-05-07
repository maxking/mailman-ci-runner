# About this Repo

This is the docker image that is used to run ci-tests for mailman using
Gitlab-CI. We use `docker` system to run tests inside the containers built
from this image. For more information on how to use [gitlab-ci-multi-runner][1],
refer to [this][2] documentation.

## How to build?

To build this image run:

```bash
	$ docker build -t mailman-runner .
```


## How to use this image?

Just add the line `image: maxking/mailman-ci-runner` to the top of your
`.gitlab-ci.yml` file. This will make sure this docker image is used to execute
the tests. You can either use Gitlab's shared runners or deploy your own
`gitlab-ci-multi-runner`. Please refer to Gitlab's documentation on how to
deploy and configure it yourself.


[1]: https://gitlab.com/gitlab-org/gitlab-ci-multi-runner
[2]: https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/configuration/advanced-configuration.md
