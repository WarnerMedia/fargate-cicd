FROM ubuntu:24.04

# install cli tools
ENV DOCKER_VERSION=29.2.1
ENV DC_VERSION=v5.0.2
ENV FARGATE_VERSION=v0.14.6

RUN apt-get update && \
  apt-get install --no-install-recommends -y \
  apt-transport-https \
  ca-certificates \
  ssh \
  git \
  bzip2 \
  curl \
  software-properties-common \
  jq \
  make \
  python3-pip \
  unzip && \
  rm -rf /var/lib/apt/lists/*

RUN curl -sSfLO "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" && \
  tar xzvf docker-${DOCKER_VERSION}.tgz --strip 1 -C /usr/local/bin docker/docker && \
  rm docker-${DOCKER_VERSION}.tgz

RUN curl -sSfLo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/${DC_VERSION}/docker-compose-`uname -s`-`uname -m` && \
  chmod +x /usr/local/bin/docker-compose

RUN curl -sSfL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip && \
  unzip /tmp/awscliv2.zip -d /tmp && \
  /tmp/aws/install && \
  rm -rf /tmp/awscliv2.zip /tmp/aws

RUN curl -sSfLo /usr/local/bin/fargate https://github.com/turnerlabs/fargate/releases/download/${FARGATE_VERSION}/ncd_linux_amd64 && \
  chmod +x /usr/local/bin/fargate

RUN mkdir -p /project && \
  echo "alias dc=docker-compose" >> ~/.bashrc && \
  echo "alias f=fargate" >> ~/.bashrc



WORKDIR /project

CMD ["/bin/bash"]
