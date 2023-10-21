#!/usr/bin/env bash

set -e
bundle exec jekyll build
pkgx aws-vault  exec --backend=file site-builder -- pkgx aws s3 sync ./_site/ s3://nottoobadsoftware.com --acl public-read --delete