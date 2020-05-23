#!/bin/bash

set -eo pipefail

xcodebuild -project CrossRaysUnitBrowser.xcodeproj \
            -scheme CrossRaysUnitBrowser \
            -sdk iphoneos \
            -configuration Release \
            -archivePath $PWD/build/CrossRaysUnitBrowser.xcarchive \
            clean archive | xcpretty