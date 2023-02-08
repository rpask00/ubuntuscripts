#!/bin/sh
./fetch_configs.sh

git add .

today=$(date '+%d.%m.%Y')
time=$(date '+%H:%M')

commitmsg="$today $time"

echo "$commitmsg"


git commit -m "$commitmsg"
git push

