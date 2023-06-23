#!/bin/bash
cd ~/dev/rf-www-push

branch=""
while getopts 'drij' OPTION; do
  case "$OPTION" in
    d)
      branch='develop'
      ;;
    r)
      branch='relcan'
      ;;

    j)
      branch='Jrelease'
      ;;
    i)
      git checkout $branch
      git pull
      echo "running install"
      npm i --legacy-peer-deps
      ;;
  esac
done
shift "$(($OPTIND -1))"

echo $branch

git checkout $branch
git checkout .
git pull
echo "Building and pushing $branch" 
ng build --configuration production

cd ~/dev/rf-www-build/
git checkout $branch


sudo rm ~/dev/rf-www-build/*
sudo rm -rf ~/dev/rf-www-build/assets

cp -a ~/dev/rf-www-push/dist/. ~/dev/rf-www-build/

today=$(date '+%d.%m.%Y')
time=$(date '+%H:%M')

commitmsg="$branch $today $time"

echo "$commitmsg"

git add .
git commit -m "$commitmsg"
git push

