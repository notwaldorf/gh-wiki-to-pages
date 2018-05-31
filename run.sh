#!/bin/bash -e

# This script pushes a demo-friendly version of your element and its
# dependencies to gh-pages.

# A gh-pages branch needs to exist, so before you run this script for the
# first time ever, make sure you ran
#     git branch -b gh-pages
#     git push --set-upstream origin gh-pages
# You don't ever need to run this again.

# Run in a clean directory passing in a GitHub org and repo name
org="notwaldorf"
repo="test-gh-pages-script"
folder="docs-pages"
#branch="master" # default to master when branch isn't specified

# make folder (same as input, no checking!)
rm -rf $repo
mkdir $repo
git clone https://github.com/$org/$repo.git --single-branch

# switch to gh-pages branch
pushd $repo >/dev/null
git checkout --orphan gh-pages

# right now in this directory you have everything
# in the original $repo folder.

## clone the wiki in here
git clone https://github.com/$org/$repo.wiki.git --single-branch $folder

# Jekyll requires blog post files to be named according to the following format:
# YEAR-MONTH-DAY-title.md
echo "renaming wiki pages..."
for file in $folder/*.md
do
  mv "$file" "2018-05-31-${file}"
done

# copy the wiki into to docs-site/_posts folder.
echo "copying wiki pages over..."
cp -R $folder/* docs-site/_posts/

# we don't need that git repo anymore
rm -rf $folder

# send it all to github
git add -A .
git commit -am 'deploy to gh-pages'
git push -u origin gh-pages --force

popd >/dev/null
