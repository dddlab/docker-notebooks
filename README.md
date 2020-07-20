# JupyterLabs on Eucalytpus

## Mounting
- Copy everything `/home` to `/mnt`.  Make sure everything has ubuntu read priviliges.  If it's root you'll get locked out.
- Edit `/etc/fstab` to set mount point from `/mnt` to `/home`
- `sudo mount /dev/vdb /home` and `sudo umount /mnt`

## Update ubunutu version
`do-release-upgrade`

## Docker Set Up
- https://docs.docker.com/engine/install/ubuntu/

- https://docs.docker.com/engine/install/linux-postinstall/

- Set install directory at /lib/systemd/system/docker.service to somewhere in `/home`, e.g. `ExecStart=/usr/bin/dockerd -g /home/docker -H fd:// --containerd=/run/containerd/containerd.sock`
  1. sudo systemctl stop docker
  2. sudo systemctl daemon-reload
  3. sudo systemctl start docker

- https://docs.docker.com/compose/install/

## Launch Jupyterhub

- run `./setup.sh` and enter passphrase
- `IMAGE=python-rstudio-notebook docker-compose up`
