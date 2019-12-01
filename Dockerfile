FROM quay.io/python-devs/ci-image:master

# Enable source repositories so we can use `apt build-dep` to get all the
# build dependencies for Python 2.7 and 3.5.
RUN sed -i -- 's/#deb-src/deb-src/g' /etc/apt/sources.list && \
    sed -i -- 's/# deb-src/deb-src/g' /etc/apt/sources.list

# Add a new layer to cache static stuff.
# Add a new user
RUN useradd runner --create-home \
    # Create and change permissions for builds directory
    && mkdir /builds \
    && chown runner /builds \
    && export LC_ALL=C.UTF-8 && export LANG=C.UTF-8

# Add the configuration files to the container.
COPY mysql.cfg postgres.cfg /home/runner/configs/

# Change the permissions for configs directory.
RUN chown -R runner:runner /home/runner/configs \
    # Install the depdencies in the repo.
    && apt-get -y update && apt-get -y install python-pip python3-pip \
    git openssh-server postgresql-client libpq-dev python3-dev \
    libsqlite3-dev libmysqlclient-dev libreadline-dev libbz2-dev \
    python-dev

# Switch to runner user and set the workdir
USER runner
WORKDIR /home/runner
