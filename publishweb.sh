#!/bin/zsh

cp -R build/web/* ../githubio/numberbonds
cd ../githubio
git commit -a -m "publish numberbonds"
git push


