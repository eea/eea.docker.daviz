FROM eeacms/plone:4.3.6-hotfix20150910

ENV CONFIG buildout.cfg

COPY buildout.cfg /opt/zope/buildout.cfg

RUN ./install.sh
