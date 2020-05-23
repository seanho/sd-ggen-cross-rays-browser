#!/bin/bash

set -eo pipefail

xcodebuild -workspace CrossRaysUnitBrowser.xcworkspace \
            -scheme CrossRaysUnitBrowser \
            -sdk iphoneos \
            -configuration Release \
            -archivePath $PWD/build/CrossRaysUnitBrowser.xcarchive \
            clean archive | xcpretty