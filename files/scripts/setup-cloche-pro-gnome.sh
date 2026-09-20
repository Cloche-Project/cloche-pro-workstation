#!/usr/bin/env bash
set -eoux pipefail

fc-cache -f
update-desktop-database /usr/share/applications