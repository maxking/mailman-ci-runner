FROM quay.io/python-devs/ci-image:master

USER root

# Add the configuration files to the container.
COPY mysql.cfg postgres.cfg /home/runner/configs/

# Change the permissions for configs directory.
RUN chown -R runner:runner /home/runner/configs \
    # Install the depdencies in the repo.
    && apt-get -y update && apt-get -y install python3-pip \
    openssh-server postgresql-client libpq-dev python3-dev \
    libsqlite3-dev libmysqlclient-dev libreadline-dev libbz2-dev
# Switch to runner user and set the workdir
USER runner
WORKDIR /home/runner
