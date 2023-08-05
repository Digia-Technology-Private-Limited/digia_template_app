#!/bin/bash
npm ci
node buildScript.js
cd ..
flutter pub get
flutter pub run flutter_flavorizr
flutter pub run flutter_launcher_icons -f flutter_launcher_icons_web.yaml
git checkout -- lib/main.dart
