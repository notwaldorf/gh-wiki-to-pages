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
folder="_posts"

# make folder (same as input, no checking!)
rm -rf $repo
mkdir $repo
git clone https://github.com/$org/$repo.git --single-branch

# switch to gh-pages branch
pushd $repo >/dev/null
git checkout --orphan gh-pages

rm .gitignore
echo '*' >> .gitignore          # ignore everything
echo '!_layouts/' >> .gitignore  # except for these jekyll things
echo '!_posts/' >> .gitignore
echo '!_config.yml' >> .gitignore
echo '!index.html' >> .gitignore

## copy everything from the docs-site in here
cp -R docs-site/* .

## clone the wiki in here
git clone https://github.com/$org/$repo.wiki.git --single-branch $folder

# remove the .git folder from the wiki repo
rm -rf $folder/.git

# Jekyll requires blog post files to be named according to the following format:
# YEAR-MONTH-DAY-title.md
echo "renaming wiki pages..."
cd $folder
for file in *.md
do
  mv "$file" "2018-05-31-${file}"
done
cd ..

# copy everything from the docs
# send it all to github
git add -A .
git commit -am 'deploy to gh-pages'
git push -u origin gh-pages --force

popd >/dev/null
