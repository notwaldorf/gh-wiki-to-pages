# `gh-pwages-to-wiki`

Sometimes you might have a wiki and sometimes you might also want to
publish this as a static site as a `gh-pages` branch and I haven't
found a way to do this, so here is my approach.

## Prerequisites
You need to have Jekyll installed.

## Configure it
You need to specify your project and the wiki link in both `deploy.sh`
and `docs-site/fetch-wiki.sh`

## Test the site locally

```
cd docs_site
sh fetch-wiki.sh
jekyll serve --watch
```

## Deploy to gh-pages
```
sh deploy.sh
```
