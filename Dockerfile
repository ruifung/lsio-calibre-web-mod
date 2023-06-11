ARG CALIBRE_RELEASE
ARG BUILDARCH
FROM lscr.io/linuxserver/calibre-web:2021.12.16
COPY setup-calibre.sh /setup-calibre.sh
RUN CALIBRE_RELEASE=${CALIBRE_RELEASE} chmod u+x /setup-calibre.sh && /setup-calibre.sh
