#!/usr/bin/env bash

virsh --connect qemu:///system start "win11" &&
    virt-manager --connect qemu:///system --show-domain-console "win11"
