#!/bin/zsh

START_TIME=$SECONDS

echo '=== CLEAN ==='
flutter clean

echo '=== TESTS ==='
TEST_RESULTS=$(flutter test)
echo "Test results ${TEST_RESULTS}"

# Android
echo '=== BUILDING ANDROID ==='
flutter build appbundle --release
# RELEASE:
# upload build/app/outputs/bundle/release/app-release.aab to play store

# iOS
echo '=== BUILDING iOS ==='
flutter build ipa --release
# RELEASE:
# > open build/ios/archive/Runner.xcarchive
# -> verify -> distribute

# Web
echo '=== BUILDING WEB ==='
flutter build web --release
# RELEASE:
# > cp -R build/web/* ../githubio/numberbonds/
# > cd ../githubio/numberbonds
# > git commit -a -m "release"
# > git push

ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "Build duration $ELAPSED_TIME seconds"

