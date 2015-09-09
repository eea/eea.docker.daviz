FROM eeacms/plone:4.3.6

ENV CONFIG buildout.cfg

COPY buildout.cfg /opt/zope/buildout.cfg

RUN ./install.sh
