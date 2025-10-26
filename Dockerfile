ARG CALIBRE_RELEASE
ARG BUILDARCH
FROM lscr.io/linuxserver/calibre-web:version-0.6.25
COPY setup-calibre.sh /setup-calibre.sh
RUN CALIBRE_RELEASE=${CALIBRE_RELEASE} chmod u+x /setup-calibre.sh && /setup-calibre.sh
