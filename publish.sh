#!/bin/bash

# the assignment operation
commit_text="Update docs"
if [ ! -z $1 ]; then
    commit_text=$1
fi 

# install the plugins and build the static site
gitbook install && gitbook build

# checkout to the gh-pages branch
git checkout gh-pages

# pull the latest updates
git pull origin gh-pages --rebase

# copy the static site files into the current directory.
cp -R _book/* .

# remove 'node_modules' and '_book' directory
# Delete all files that are not tracked in the current directory, regardless of whether they are specified folders and files in the.gitignore file

git clean -fx node_modules
git clean -fx _book

# add all files
git add .

# commit
git commit -a -m ${commit_text}

# push to the origin
git push origin gh-pages

# checkout to the master branch
git checkout master