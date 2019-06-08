
set -e
.  ./_test.sh
aws-vault exec site-builder -- bundle exec s3_website push