#!/bin/bash -e

wiki="polymer/pwa-starter-kit.wiki"

# cleanup
cd docs-site
rm -rf _posts

echo "cloning wiki..."
git clone https://github.com/$wiki.git --single-branch _posts
rm -rf _posts/.git

# Jekyll requires blog post files to be named according to the following format:
# YEAR-MONTH-DAY-title.md
echo "renaming wiki pages..."
cd _posts
mkdir temp
for file in *.md
do
  # prepend the post type
  echo '---\nlayout: post\n---' | cat - $file > temp/$file && mv temp/$file $file

  mv "$file" "2018-05-31-${file}"
done
rm -rf temp
cd ..

echo "done!"
