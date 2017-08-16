# docker-subversion

## Volumes
To use this container, you should prepare these volumes:

### /etc/apache2/dav_svn

Contained 2 files:

	authz
		a authz file to control the access to your subversion repositories

	htpasswd
		a htpasswd file to manage the users for this subversion system

### /var/lib/svn

All svn data is stored in this volume

## How to build

	docker build --force-rm --pull --tag=services:svn .

## Start command

	docker run --restart=always -d -p 8000:80 --name svn -v /srv/docker-subversion/dav_svn:/etc/apache2/dav_svn -v /srv/docker-subversion/svn:/var/lib/svn services:svn

	> Exposing port 8000 on the host leaves open the possibility to proxy the container with nginx or another webserver and doesn't conflict with a previously running webserver on the host.
