#!/bin/bash -e

# This is all copied from deploy-to-gh-pages.#!/bin/sh

wiki="polymer/pwa-starter-kit.wiki"
folder="_posts"

# cleanup
cd docs-site
rm -rf $folder

echo "cloning wiki..."
git clone https://github.com/$wiki.git --single-branch $folder
rm -rf $folder/.git

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

echo "done!"
