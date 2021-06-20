# Number bonds

A very simple app for kids to practice number bonds of 10 (e.g. 4+6=10, 8+2=10, etc.). Has a variable daily goal to aid regular practice.

Play Store [here](https://play.google.com/store/apps/details?id=com.purposebakery.numberbonds) 

App Store: [here](https://apps.apple.com/us/app/free-education-number-bonds/id1571018744)

Web: [here](https://purposebakery.github.io/numberbonds/#/) (only works on Chrome at this point?)

## Backlog

### Must do

- integrate test into "pipeline"

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

### Process
- Increase version number in pubspec.yaml / Commit / Push
- Release build ```./buildall.sh```
- Regression test apps
- Tag commit ```git tag v1.0.0```
- Publish
5. (optional) release notes
6. (optional) update store listings
7. (optional) create / update screenshots


### Android 

#### Build
```flutter build appbundle --release```

#### Publish
1. Play Store: upload build/app/outputs/bundle/release/app-release.aab
2. Play Store: publish release


### iOS 

#### Build
```flutter build ipa --release```

#### Publish
1. ```open build/ios/archive/Runner.xcarchive```
2. xcode: Validate app
3. xcode: Distribute app
4. App Store Connect: Fest flight / Distribute
5. App Store Connect: Production / Distribute


### Web 

#### Build
```flutter build web --release```

#### Publish
```./publishweb.sh```
