#!/bin/bash

set -eo pipefail

BUNDLE_SHORT_VERSION=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "./CrossRaysUnitBrowser/Info.plist")
BUNDLE_VERSION="$BUNDLE_SHORT_VERSION.$RUN_NUMBER"

/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $BUNDLE_VERSION" "./CrossRaysUnitBrowser/Info.plist"