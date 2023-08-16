#!/bin/bash
# Check if both arguments were provided
if [ $# -ne 2 ]; then
    echo "userId and previewId are required"
    exit 1
fi
userId="$1"
projectId="$2"
git reset --hard HEAD
git clean -fd
# git pull origin main
npm ci
node buildScript.js "$userId" "$projectId"
cd ..
flutter clean
flutter pub get
flutter pub run flutter_flavorizr
flutter pub run flutter_launcher_icons -f flutter_launcher_icons_web.yaml
git checkout -- lib/main.dart
