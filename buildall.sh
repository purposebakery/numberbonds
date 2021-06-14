#!/bin/zsh

START_TIME=$SECONDS

# Android
echo '=== BUILDING ANDROID ==='
flutter build appbundle --release
# RELEASE: upload build/app/outputs/bundle/release/app-release.aab to play store

# iOS
echo '=== BUILDING iOS ==='
flutter build ipa --release
# RELEASE: open build/ios/archive/Runner.xcarchive

# Web
echo '=== BUILDING WEB ==='
flutter build web --release
# RELEASE: 
# > cd ../githubio/numberbonds
# > git commit -a -m "release"
# > git push

ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "Build duration $ELAPSED_TIME seconds"

