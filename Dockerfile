FROM eeacms/plone:4.x

ENV CONFIG buildout.cfg

COPY buildout.cfg /opt/zope/buildout.cfg

USER root
RUN ./install.sh
USER zope-www
