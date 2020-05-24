#!/bin/sh

set -eo pipefail

gpg --quiet --batch --yes --decrypt --passphrase="$PROFILE_PASSPHRASE" --output ./.github/secrets/Cross_Rays_Distribution.mobileprovision ./.github/secrets/Cross_Rays_Distribution.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$CERT_PASSPHRASE" --output ./.github/secrets/AppStore.p12 ./.github/secrets/AppStore.p12.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp ./.github/secrets/Cross_Rays_Distribution.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/Cross_Rays_Distribution.mobileprovision

security create-keychain -p "" build.keychain
security import ./.github/secrets/AppStore.p12 -t agg -k ~/Library/Keychains/build.keychain -P "" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain