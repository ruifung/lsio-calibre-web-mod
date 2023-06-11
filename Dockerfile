ARG CALIBRE_RELEASE
ARG BUILDARCH
FROM lscr.io/linuxserver/calibre-web:0.6.20
COPY setup-calibre.sh /setup-calibre.sh
RUN CALIBRE_RELEASE=${CALIBRE_RELEASE} chmod u+x /setup-calibre.sh && /setup-calibre.sh
