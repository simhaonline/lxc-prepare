#!/bin/bash
### Debian distro specific init settings

## See: https://github.com/lxc/lxd/issues/4939
systemctl mask systemd-networkd
## Create default user for mapping to id 1000 to be able to mount and use host fs
useradd -m -p debian debian
