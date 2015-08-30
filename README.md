# amitools

## Overview

Installs EC2 AMI tools. Recommend accepting the defaults.

In particular, building AMIs with Packer results in `ec2-bundle-vol` being invoked via `sudo`,
which means that tool needs to not only in `$PATH`, but in a directory in `$PATH` that is
included in the `secure_path` directive in `/etc/sudoers`.

Tested on Ubuntu.

