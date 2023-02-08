# !/bin/bash
cd ~/dev/rf-www-build/

git checkout develop

sudo rm ~/dev/rf-www-build/*
sudo rm -rf ~/dev/rf-www-build/assets

cp -a ~/dev/rf-www/dist/. ~/dev/rf-www-build/

dev="dev "
today=$(date '+%d.%m.%Y')
time=$(date '+%H:%M')

commitmsg="$dev$today $time"

echo "$commitmsg"

git add .
git commit -m "$commitmsg"
git push
