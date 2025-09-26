#!/bin/bash

set -ouex pipefail

for pkg in kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra; do
    rpm --erase $pkg --nodeps
done

KERNEL_VERSION="$(find /tmp/kernel-rpms/kernel-core-*.rpm -prune -printf "%f\n" | sed 's/kernel-core-//g;s/.rpm//g')"

KERNEL_RPMS=(
    "/tmp/kernel-rpms/kernel-${KERNEL_VERSION}.rpm"
    "/tmp/kernel-rpms/kernel-core-${KERNEL_VERSION}.rpm"
    "/tmp/kernel-rpms/kernel-modules-${KERNEL_VERSION}.rpm"
    "/tmp/kernel-rpms/kernel-modules-core-${KERNEL_VERSION}.rpm"
    "/tmp/kernel-rpms/kernel-modules-extra-${KERNEL_VERSION}.rpm"
)
dnf5 -y install "${KERNEL_RPMS[@]}"
dnf5 versionlock add kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra
