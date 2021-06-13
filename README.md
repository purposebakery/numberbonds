# Number bonds

A very simple app for kids to practice number bonds of 10 (e.g. 4+6=10, 8+2=10, etc.). Has a variable daily goal to aid regular practice.

## Backlog

### Pipelines

- Android build + Release
- iOS build + Release
- Web build + deployment

### Framework

- Unit tests?
- UI tests

### Features

- optimize for tablet
- add i18n
- add wrong input visuals 
- add more difficult number bond modes (x,y[1-9])
- dark theme
- add error count to home

## Releasing

1. Increase version number in pubspec.yaml
2. Commit / Push version number increase
3. Tag commit ```git tag v1.0.0```
4. Build / publish releases
5. (optional) release notes
6. (optional) update store listings

### Android release

1. ```flutter build appbundle --release```
2. Play Store upload build/app/outputs/bundle/release/app-release.aab

### iOS release

1. ```flutter build ipa --release```
2. ```open build/ios/archive/Runner.xcarchive```
3. xcode: Validate app
4. xcode: Distribute app
5. App Store Connect: Fest flight / Distribute

### Web Release

TODO
