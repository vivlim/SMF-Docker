# smf-podman
basic simple machines forum dev environment in rootless podman

- apache
- php-fpm
- mariadb

containers run as the current user, so you can easily make changes in `./www` without needing to fiddle with permissions.

tested on fedora 41 with selinux enabled

## Setup
1. download the smf install zip and extract into `./www/smf`
e.g.:
```
curl "https://download.simplemachines.org/index.php/smf_2-1-4_install.tar.bz2" | tar xj --directory ./www/smf
```

### 2. set up rootless podman services
whatever you need to do in your environment to get `podman compose` working; on fedora 41, this'll do:

```sh
systemctl enable --user podman
systemctl start --user podman
```

### 3. start the containers
```sh
podman compose up
```

if all went well, you should be able to go to http://localhost:8000/smf.

## troubleshooting

some things you can try looking at:

- `./http_logs/access.log` and `./http_logs/error.log`
- `./php_logs/error.log`
- `podman compose logs web`
- `podman compose logs db`
- http://localhost:8000/phpinfo.php

## references & inspirations
- originally based on https://github.com/vortexau/SMF-Docker
- https://github.com/8ctopus/apache-php-fpm-alpine
- https://github.com/TrafeX/docker-php-nginx
- other tabs i did not save :(