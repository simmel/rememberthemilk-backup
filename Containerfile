FROM debian:trixie-slim@sha256:a2ca65377c251208de42e1a2722cb949211236c161b634f6f3663754e2d06850

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
