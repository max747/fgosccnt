#!/bin/bash

git checkout master
git fetch upstream --prune
git merge upstream/master --ff
git push
git checkout linux
git rebase master
