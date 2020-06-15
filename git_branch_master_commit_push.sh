#!/bin/bash

# https://gist.github.com/drewsberry/1b9fc80682edd8bcecc4
# Run this script in the root directory of your Jekyll source
# repository for your GitHub page, and it will commit and push
# the source to origin/source, then build, commit and push the
# resulting HTML to your origin/master, i.e. your website. The
# commit message for both commits is given by the first
# argument.

if [[ -z "$1" ]]; then
  echo "Please enter a git commit message."
  exit
fi

git checkout gh-pages && \
  git add . && \
  git commit -am "$1" && \
  git push origin gh-pages && \
  echo "Source successfully pushed to GitHub."
  bundle exec jekyll build && \
  touch _site/.nojekyll && \
  cd _site && \
  git add . && \
  git commit -am "$1" && \
  git push origin master && \
  cd .. && \
  echo "Site successfully build and pushed to GitHub."