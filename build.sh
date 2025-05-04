#!/bin/bash

set -e

# Decompile with Apktool (decode resources + classes)
wget -q https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.11.1.jar -O apktool.jar
java -jar apktool.jar d ff.apk -o ff-extracted  # -s flag removed
rm -rf ff-extracted/META-INF

pushd ff-extracted

function patch() {
	local name="$1"
	echo "[INFO] Patching $name"
	. "$name"
}

patch ../patches/0000-black.sh
patch ../patches/0001-rm-telemetry-ext.sh
patch ../patches/0002-nav-layout.sh
patch ../patches/0003-about-config.sh

popd

# Recompile the APK
java -jar apktool.jar b ff-extracted -o ff-patched.apk --use-aapt2

# Align and sign the APK
zipalign 4 ff-patched.apk ff-patched-signed.apk

# Clean up
rm -rf ff-extracted ff-patched.apk
