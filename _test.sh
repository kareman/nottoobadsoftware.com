bundle exec jekyll build
bundle exec htmlproofer --assume-extension --check-html --internal-domains nottoobadsoftware.com --url-ignore "/bitbucket\.org/" ./_site
