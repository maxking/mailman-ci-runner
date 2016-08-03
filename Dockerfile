FROM ubuntu:16.04

# Install the depdencies in the repo.
RUN apt-get -y update && apt-get -y install python-pip python3-pip \
    git openssh-server postgresql-client libpq-dev python3-dev \
    libsqlite3-dev libmysqlclient-dev libreadline-dev python-dev


# Install latest version of tox.
RUN pip3 install tox

# Add a new user
RUN useradd runner --create-home

# Create and change permissions for builds directory
RUN mkdir /builds
RUN chown runner /builds

# Set password for runner user and make it visible for SSH
# This section is probably not needed now, but it is required
# if you need to SSH in using this user
# RUN echo 'runner:runner' | chpasswd
# ENV NOTVISIBLE "in users profile"
# RUN echo "export VISIBLE=now" >> /etc/profile

# Download and compile the Python3.4 version.
WORKDIR /tmp/
RUN wget https://www.python.org/ftp/python/3.4.5/Python-3.4.5.tgz
RUN tar xzf Python-3.4.5.tgz
WORKDIR /tmp/Python-3.4.5
RUN ./configure
RUN make
RUN make install

# Add the configuration files to the container.
COPY mysql.cfg postgres.cfg /home/runner/configs/

# Change the permissions for configs directory.
RUN chown -R runner:runner /home/runner/configs

# Switch to runner user and set the workdir
USER runner
WORKDIR /home/runner
