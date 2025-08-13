#!/bin/bash

date=$(date)

mdbook build
cp -R book/* pages/
cd pages
git add -A
git commit -m "Rebuild: $date"
git push
cd ..
rm -rf public
git commit -am "Pages update: $date"
git push
