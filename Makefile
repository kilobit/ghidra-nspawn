# Makefile
#
# Download and build a containerized environment for SRE.
#
# @Author: Christian Saunders
# @Created: Dec 3, 2019
# @Company: Kilobit Labs Inc.
# @Licence: Copyright 2019
#

exec_dir        := $(shell pwd)
mkfile_path     := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir      := $(dir $(mkfile_path))
prefix          := $(mkfile_dir)
bindir          := ~/bin
project         := ghidra

.NOTPARALLEL:

.PHONY: title end force vars clean $(project)

all: title $(project) end

title:
	@echo -e "Setting Up The Android Environment"
	@echo -e "========================================="
	@echo -e ""

end:
	@echo -e ""
	@echo -e "End of Run."
	@echo -e "========================================="

force:

vars: vars_sdk vars_android_sh
	@echo -e "Prefix: $(prefix)"
	@echo -e "Execution Directory: $(exec_dir)"
	@echo -e "Makefile Path: $(mkfile_path)"

install: install_android_sh

clean: container_clean

# Build the nspawn environment.
container_path	:= "./ghidra"
container_user	:= ghidra
ghidra_repo	:= "https://aur.archlinux.org/ghidra-git.git"
ghidra_dir	:= "/home/ghidra/ghidra-git/"

.PHONY: container_bootstrap container_networking container ghidra container_clean

$(container_path):
	mkdir -p $(container_path)

container_bootstrap: $(container_path)
	sudo pacstrap -i -c -d $(container_path) base base-devel git java-environment --ignore linux --ignore linux-firmware

container_networking: container_bootstrap
	sudo systemd-nspawn --directory=$(container_path) systemctl enable systemd-networkd
	sudo systemd-nspawn --directory=$(container_path) systemctl enable systemd-resolved

container_users: container_bootstrap
	sudo systemd-nspawn --directory=$(container_path) sh -c '\
	if [ ! $$(id -u $(container_user) > /dev/null 2>&1) ]; then \
		useradd $(container_user); \
		echo "$(container_user)  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/99_sudo_include_file; \
	fi'

container: container_bootstrap container_networking container_users

ghidra: container
	sudo systemd-nspawn --directory=$(container_path) --user=$(container_user) sh -c "if [ ! -e $(ghidra_dir) ]; then git clone $(ghidra_repo) $(ghidra_dir); fi"
	sudo systemd-nspawn --directory=$(container_path) --chdir=$(ghidra_dir) --user=$(container_user) makepkg -si

container_clean:
	sudo rm -rf $(container_path)