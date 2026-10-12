FROM debian:trixie-slim@sha256:a29215f6a35e51e22adffa17f89e9d2ef06214e64a2bad10d765c46aea49f11f

WORKDIR /srv
ENV USERNAME=username
ENV PASSWORD=password
ENV SSH_KEY=/srv/ssh_key
ENV SCP_URL=user@host:/path/

RUN apt-get -qq update && apt-get -qq install \
      curl \
      openssh-client \
      && chown -R 1000:1000 /srv \
      && rm -rf /var/lib/apt/lists/*

USER 1000
ADD backup.sh /srv/

ENTRYPOINT ["/srv/backup.sh"]
