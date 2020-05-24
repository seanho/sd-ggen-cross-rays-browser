#!/bin/bash

set -eo pipefail

PR_NUMBER=$(echo $GITHUB_REF | awk 'BEGIN { FS = "/" } ; { print $3 }')
BUNDLE_SHORT_VERSION=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "./CrossRaysUnitBrowser/Info.plist")
BUNDLE_VERSION="$BUNDLE_SHORT_VERSION.$PR_NUMBER"

/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $BUNDLE_VERSION" "./CrossRaysUnitBrowser/Info.plist"