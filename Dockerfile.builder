FROM debian:stretch-slim

# Defining default Java and Maven version
ARG JAVA_VERSION="11.0.9.j9-adpt"
ARG GRADLE_VERSION="6.8.1"

# Installing basic packages
RUN apt-get update && \
	apt-get install -y zip unzip curl && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/*

# Downloading SDKMAN!
RUN curl -s "https://get.sdkman.io" | bash

# Installing Java and Maven, removing some unnecessary SDKMAN files
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
    yes | sdk install java $JAVA_VERSION && \
    yes | sdk install gradle $GRADLE_VERSION && \
    rm -rf $HOME/.sdkman/archives/* && \
    rm -rf $HOME/.sdkman/tmp/*"

ENV GRADLE_HOME="/root/.sdkman/candidates/gradle/current"
ENV JAVA_HOME="/root/.sdkman/candidates/java/current"
ENV PATH="$GRADLE_HOME/bin:$JAVA_HOME/bin:$PATH"
