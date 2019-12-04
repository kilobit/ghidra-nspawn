Ghidra - nspawn
===============

A self contained environment for running the Ghidra SRE tool.

Avoid splattering otherwise unnecessary dependencies around your
system and work in peaceful isolation.  Requires the Arch Linux
*pacman* and *pacstrap* tools to build.

What is *Ghidra*?  [*Ghidra*](https://ghidra-sre.org/) is an
alternative to commercial disassembler and Software Reverse
Engineering tools such as 
[IDA Pro](https://en.wikipedia.org/wiki/Interactive_Disassembler).
*Ghidra* was built by the US NSA and released as 
[open source](https://github.com/NationalSecurityAgency/ghidra).

Status: Working

Build with one command:
```{.bash}
$ git clone https://github.com/kilobit/ghidra-nspawn
$ make
...
```
Building will require sudo access to the local machine and you will
have to acknowledge the continuation prompts.  All of the defaults
seem to be work.  The *Enter/Return* key is your friend.

Launch Ghidra with 2:
```{.bash}
$ make shell
sudo systemd-nspawn --directory="./ghidra" --chdir=/home/ghidra \
...
Spawning container ghidra on ...
Press ^] three times within 1s to kill container.
[ghidra@ghidra ~]$ ghidra
[ghidra@ghidra ~]$ 
```

As nspawn is running a container, it will require *sudo* access to
run.  Ghidra-nspawn is meant to leave no trace on the host machine and
so it is not currently designed to be installed and administered with
*machinectl* etc.  Please consider contributing if this would be a
useful feature.

Features
--------

- Quickly builds Ghidra based on the ghidra-git AUR package.
- Launches a container configured to use your local X session.
- Requires no modification to your Arch system.
- *clean* target removes all downloaded and generated components.

To-Do:
- Make the build process standalone.
- Launch Ghidra with a single command (possibly shell).
- Expand this into a full SRE environment.

Installation
------------

```{.bash}
$ git clone https://github.com/kilobit/ghidra-nspawn
```

Contribute
----------

Contributions are welcome!

Please submit a pull request with any bug fixes or feature requests
that you have.  All submissions imply consent to use / distribute
under the terms of the LICENSE.

See Other
---------

* [*Ghidra*](https://ghidra-sre.org/) Software Reverse Engineering
  (SRE) Suite.
* [*ghidra-git*](https://aur.archlinux.org/packages/ghidra-git/) AUR Package.

Support
-------

Submit tickets through [github](https://github.com/kilobit/ghidra-nspawn).

License
-------

See LICENSE.

--  
Created: Dec 5, 2019  
By: Christian Saunders <cps@kilobit.ca>  
Copyright 2019 Kilobit Labs Inc.  
