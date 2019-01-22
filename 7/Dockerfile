FROM registry.access.redhat.com/rhel7

LABEL maintainer="Bitnami <containers@bitnami.com>" \
      name="RHEL Extras" \
      version="7.x" \
      release="4" \
      io.k8s.display-name="RHEL Extras 7.x" \
      vendor="Bitnami" \
      summary="Bitnami RedHat Enterprise Linux base image with extras." \
      usage="This image is a generic image for Bitnami containers." \
      description="Bitnami RedHat Enterprise Linux base image with extras." \
      io.k8s.description="Bitnami RedHat Enterprise Linux base image with extras." \
      architecture="x86_64"


ENV IMAGE_OS=rhel-7

COPY rootfs /

RUN chmod 0755 / /usr /usr/local /usr/local/bin /opt && \
    yum upgrade -y && \
    install_packages tar gzip curl ca-certificates sudo procps-ng libaio-devel && \
    useradd -ms /bin/bash bitnami && \
    mkdir -p /opt/bitnami && chown bitnami:bitnami /opt/bitnami && \
    sed -i -e 's/\s*Defaults\s*secure_path\s*=/# Defaults secure_path=/' /etc/sudoers && \
    echo "bitnami ALL=NOPASSWD: ALL" >> /etc/sudoers

# The following security actions are recommended by some security scans.
# https://console.bluemix.net/docs/services/va/va_index.html
RUN sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS    90/' /etc/login.defs && \
    sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS    1/' /etc/login.defs

ENV NAMI_VERSION=1.0.0-1

RUN cd /tmp && \
    curl -sSLO https://nami-prod.s3.amazonaws.com/tools/nami/releases/nami-$NAMI_VERSION-linux-x64.tar.gz && \
    echo "80488279b056d5e9c183fe34097c5f496715ab16a602afcc9f78d59f15139a16  nami-$NAMI_VERSION-linux-x64.tar.gz" | sha256sum -c - && \
    mkdir -p /opt/bitnami/nami && \
    tar xzf nami-$NAMI_VERSION-linux-x64.tar.gz --strip 1 -C /opt/bitnami/nami && \
    rm nami-$NAMI_VERSION-linux-x64.tar.gz

ENV GPG_KEY_SERVERS_LIST ha.pool.sks-keyservers.net \
                         hkp://p80.pool.sks-keyservers.net:80 \
                         keyserver.ubuntu.com \
                         hkp://keyserver.ubuntu.com:80 \
                         pgp.mit.edu

ENV TINI_VERSION=v0.13.2 \
    TINI_GPG_KEY=595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7

RUN cd /tmp && \
    for server in $(shuf -e $GPG_KEY_SERVERS_LIST) ; do \
        gpg --keyserver "$server" --recv-keys $TINI_GPG_KEY && break || : ; \
    done && \
    gpg --fingerprint $TINY_GPG_KEY | grep -q "Key fingerprint = 6380 DC42 8747 F6C3 93FE  ACA5 9A84 159D 7001 A4E5" && \
    curl -sSL https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini.asc -o tini.asc && \
    curl -sSL https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini -o /usr/local/bin/tini && \
    gpg --verify tini.asc /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini && \
    rm tini.asc

ENV GOSU_VERSION=1.10 \
    GOSU_GPG_KEY=B42F6819007F00F88E364FD4036A9C25BF357DD4

RUN cd /tmp && \
  for server in $(shuf -e $GPG_KEY_SERVERS_LIST) ; do \
      gpg --keyserver "$server" --recv-keys $GOSU_GPG_KEY && break || : ; \
  done && \
  gpg --fingerprint $GOSU_GPG_KEY | grep -q "Key fingerprint = B42F 6819 007F 00F8 8E36  4FD4 036A 9C25 BF35 7DD4" && \
  curl -sSL https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64.asc -o gosu.asc && \
  curl -sSL https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64 -o /usr/local/bin/gosu && \
  gpg --verify gosu.asc /usr/local/bin/gosu && \
  chmod +x /usr/local/bin/gosu && \
  rm gosu.asc

ENV PATH=/opt/bitnami/nami/bin:$PATH
ENV BITNAMI_IMAGE_VERSION=7-r233

ENTRYPOINT ["/entrypoint.sh"]
