#!/bin/bash -e

# Run in a clean directory passing in a GitHub org and repo name
org="notwaldorf"
repo="gh-wiki-to-pages"
wiki="polymer/pwa-starter-kit.wiki"
folder="_posts"

# make folder (no checking!)
rm -rf $repo
mkdir $repo
echo "cloning... $repo"
git clone https://github.com/$org/$repo.git --single-branch

# switch to gh-pages branch
echo "switching to gh-pages branch..."
pushd $repo >/dev/null
git checkout --orphan gh-pages

# uncommit everything
echo "uncommiting everything..."
rm .gitignore
git rm -rf --cached --ignore-unmatch *

## copy everything from the docs-site in here
echo "copying jekyll folders..."
cp -R docs-site/* .

## clone the wiki in here
echo "cloning wiki..."
git clone https://github.com/$wiki.git --single-branch $folder

# remove the .git folder from the wiki repo
rm -rf $folder/.git

# Jekyll requires blog post files to be named according to the following format:
# YEAR-MONTH-DAY-title.md
echo "renaming wiki pages..."
cd $folder

# Jekyll requires blog post files to be named according to the following format:
# YEAR-MONTH-DAY-title.md
echo "renaming wiki pages..."
cd $folder
mkdir temp
for file in *.md
do
  # prepend the post type
  echo '---\nlayout: post\n---' | cat - $file > temp/$file && mv temp/$file $file
  # the date doesn't actually matter.
  mv "$file" "2018-05-31-${file}"
done
rm -rf temp
cd ..

# copy everything from the docs
# send it all to github
echo "git add-ing..."
git add _layouts
git add _posts
git add css
git add images
git add _config.yml
git add index.html

git commit -am 'deployed to gh-pages'
git push -u origin gh-pages --force

echo "done and deployed!"

popd >/dev/null
