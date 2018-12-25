#!/bin/bash

set -e
set -u
set -o pipefail

case $(uname) in
    Darwin*)
    cp -r $cur__root/platform-darwin/. $cur__install/
    ;;
    Linux*)
    cp -r $cur__root/platform-linux/. $cur__install/
    ;;
    *)
    cp -r $cur__root/platform-win32/. $cur__install/
    ;;
esac

echo Installed $cur__name to $cur__install
