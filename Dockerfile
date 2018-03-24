FROM alpine:3.6

MAINTAINER Ferry Manders "docker@blackring.net"

ENV TERRAFORM_VERSION 0.11.2

RUN apk add --no-cache \
          bash \
          curl \
          python2 \
          py2-pip \
          openssl \
          ca-certificates \
      && apk add --no-cache --virtual .build-deps \
          gcc \
          python-dev \
          libffi-dev \
          openssl-dev \
          build-base \
          unzip \
      && pip install \
          ansible \
          awscli \
      && curl -fSL https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
      && unzip terraform.zip \
      && rm terraform.zip \
      && mv terraform /bin/terraform \
      && mkdir /work \
      && apk del .build-deps


VOLUME [ "/work" ]

WORKDIR /work

CMD ['/bin/bash']
