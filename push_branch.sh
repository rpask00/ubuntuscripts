#!/bin/bash

branch=$1

cd ~/dev/rf-www-build/

git checkout $branch

sudo rm ~/dev/rf-www-build/*
sudo rm -rf ~/dev/rf-www-build/assets

cp -a ~/dev/rf-www/dist/. ~/dev/rf-www-build/

dev="$1 "
today=$(date '+%d.%m.%Y')
time=$(date '+%H:%M')

commitmsg="$dev$today $time"

echo "$commitmsg"

git add .
git commit -m "$commitmsg"
git push

