#!/bin/bash
cd ~/dev/doppler

sudo rm -rf ~/dev/doppler/doppler_dashboard-build/assets
sudo rm ~/dev/doppler/doppler_dashboard-build/*

cp -a ~/dev/doppler/doppler_dashboard/dist/doppler_dashboard/. ~/dev/doppler/doppler_dashboard-build/


cd ~/dev/doppler/doppler_dashboard-build


today=$(date '+%d.%m.%Y')
time=$(date '+%H:%M')

commitmsg="deploy $today $time"

echo "$commitmsg"

git add .
git commit -m "$commitmsg"
git push
