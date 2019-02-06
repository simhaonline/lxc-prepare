# LXD/LXC Prepare

The tool aims to help building clean local LXC container with automation of necessary initialization steps like
preconfigured package installation and so on. This is much more as a skeleton of a workflow rather than a 
real full-featured tool.

While LXD supported ``cloud-init`` only available in Ubuntu based images it is a simple substitute solution
for automate basic configuration repeating steps in a freshly created local container. It isn't depends on any 
specific packages on host just plain ``bash``.

## How to start

After clonig the repository you just have to create the container you need like this

``lxc init ubuntu:18.04 test``

Then run your init batch on the container

``./lxc-prepare.sh <container> [bundle...]``

where ``container`` is the name of created container above as ``test`` in our example, ``bundle`` is an 
argument list of init bundle names.

## Bundles

Bundles are package lists and optionally scripts that need to be run for any post- or preconfiguration in 
the container. 

## Directory structure 

```
/
|
├─ lxc-prepare.sh  - main script
├─ init-dist.sh  - origin of container side init script 
└─ <distro name> - the foldername represents init bundles of a specific container by type of OS
   ├─ init       - container based bundles
   ├─ packages   - plain text packages files grouped by bundle names
   └─ scripts    - scripts named as bundles
```

## folder names by distributions

Distro name comes from LXD image definition (_image.os_ property). All your bundles should be organized
by image os name therefore your bundles should be grouped in a folder name exactly same as in ``image.os``
defined of created container.

## init 

**init.sh** - Container side main script.

**distro.sh** - Put distribution specific scripts here.  

## packages

Packages group files are new line terminated plain text file contains package names necessary to install.
Packages will be installed if package bundle name has been specified in init scipt as argument.

## scripts

Scripts folder may contains preinstall and postinstall scripts. Scripts named by ``<bundle>.sh`` are running
before packages wil be installed ``<bundle>-post.sh`` scripts after installing packages.

---

So, now you are free to automatize your repeating containerizer tasks with the advance of keep clean and fresh
but customized containers.
