#!/usr/bin/env sh
#
# Copyright 2017 The Jaeger Authors
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
# in compliance with the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License
# is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied. See the License for the specific language governing permissions and limitations under
# the License.
#

set -e

sudo apt-get update
sudo apt-get install libncurses5-dev libslang2-dev gettext zlib1g-dev libselinux1-dev debhelper lsb-release pkg-config po-debconf autoconf automake autopoint libtool
TMP=$(mktemp -d)
cleanup_tmp () {
  rm -Rf $TMP
}
trap cleanup_tmp EXIT
cd $TMP

wget https://www.kernel.org/pub/linux/utils/util-linux/v2.30/util-linux-2.30.2.tar.gz -qO - | tar -xz -C $TMP/
cd $TMP/util-linux-2.30.2 && ./autogen.sh && ./configure && make nsenter
sudo cp $TMP/util-linux-2.30.2/nsenter $HOME/.local/bin/nsenter
sudo chmod +x $HOME/.local/bin/nsenter
sudo cp $HOME/.local/bin/nsenter /usr/bin/nsenter
