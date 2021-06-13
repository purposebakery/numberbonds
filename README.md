# Number bonds

A very simple app for kids to practice number bonds of 10 (e.g. 4+6=10, 8+2=10, etc.). Has a variable daily goal to aid regular practice.

## Backlog

- dark theme
- add i18n
- add error count to home
- add more difficult number bond modes (base 10, 1-9)

----

## Releasing

1. Increase version number in pubspec.yaml
2. 

### Android release

1. ```flutter build apk --release```
2. Play Store upload build/app/outputs/flutter-apk/app-release.apk

### iOS release

1. ```flutter build ipa --release```
2. ```open build/ios/archive/Runner.xcarchive```
3. xcode: Validate app
4. xcode: Distribute app
5. App Store Connect: Fest flight / Distribute

### Web Release

TODO
