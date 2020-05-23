#!/bin/bash

set -eo pipefail

xcodebuild -archivePath $PWD/build/CrossRaysUnitBrowser.xcarchive \
            -exportOptionsPlist CrossRaysUnitBrowser/ExportOptions.plist \
            -exportPath $PWD/build \
            -allowProvisioningUpdates \
            -exportArchive | xcpretty