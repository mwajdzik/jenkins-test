FROM debian:stretch-slim

# Defining default Java and Maven version
ARG JAVA_VERSION="11.0.9.j9-adpt"
ARG GRADLE_VERSION="6.8.1"

# Defining default non-root user UID, GID, and name
ARG USER_UID="1000"
ARG USER_GID="1000"
ARG USER_NAME="jenkins"

# Creating default non-user
RUN groupadd -g $USER_GID $USER_NAME && \
	useradd -m -g $USER_GID -u $USER_UID $USER_NAME

# Installing basic packages
RUN apt-get update && \
	apt-get install -y zip unzip curl && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/*

# Switching to non-root user to install SDKMAN!
USER $USER_UID:$USER_GID

# Downloading SDKMAN!
RUN curl -s "https://get.sdkman.io" | bash

# Installing Java and Maven, removing some unnecessary SDKMAN files
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
    yes | sdk install java $JAVA_VERSION && \
    yes | sdk install gradle $GRADLE_VERSION && \
    rm -rf $HOME/.sdkman/archives/* && \
    rm -rf $HOME/.sdkman/tmp/*"

ENV GRADLE_HOME="/home/jenkins/.sdkman/candidates/maven/current"
ENV JAVA_HOME="/home/jenkins/.sdkman/candidates/java/current"
ENV PATH="$GRADLE_HOME/bin:$JAVA_HOME/bin:$PATH"
