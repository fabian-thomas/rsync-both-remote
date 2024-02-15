## Motivation
Have you ever found yourself in the need to quickly transfer a big directory from one to another machine?
Then this script is for you.
rsync by itself does only allow local to remote or remote to local file transfers.
This script uses the rsync daemon mode to transfer files between two remote machines.
Thereby, it supports two modes:
1. Relayed (default): Data is transferred over your local machine between two remote hosts.
   This is guaranteed to work since it uses SSH forwarding to make a connection between the machines.
   Though, it can be slow because every bit of data is moved through your machine.
2. Direct (--direct): In this mode the connection is established directly between the machines.
   This fails if the machines can't ping each other, so only use it when you know that the machines are in the same network.
   But if you use it, your transfers will be pretty fast.

## Usage
Use this script as you would use rsync, but make sure to checkout the caution section below.
```sh
rysnc-both-remote --direct user@remote-machine-1:file/in/home/dir remote-machine-2:
```

## Caution
The script currently uses the following rsync options:
```
-ahrP --delete
```
Especially the `--delete` might be too destructive for you.

## Shell completion support
Not sure if this works for bash/fish too, but this works for zsh:
``` sh
compdef rsync-both-remote=rsync
```

## Security
Security is not a primary goal of this script, although you should be pretty safe from a network attacker.
SSH port forwarding makes sure that your network is secure in the non-direct mode.
In the direct mode you should be safe since the script uses a password to init the transfer.
An attacker on your or one of the remote machines is out of the threat model this script protects you against.
To fix that you could copy the config files, especially the password and secrets files to your home directory instead of copying them to the world readable `/tmp`.
