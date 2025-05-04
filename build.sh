#!/bin/bash

set -e

# Decompile with Apktool (decode resources + classes)
wget -q https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.11.1.jar -O apktool.jar
java -jar apktool.jar d ff.apk -o ff-extracted  # -s flag removed
rm -rf ff-extracted/META-INF

# Color patching
sed -i 's/<color name="fx_mobile_layer_color_1">.*/<color name="fx_mobile_layer_color_1">#ff000000<\/color>/g' ff-extracted/res/values-night/colors.xml
sed -i 's/<color name="fx_mobile_layer_color_2">.*/<color name="fx_mobile_layer_color_2">@color\/photonDarkGrey90<\/color>/g' ff-extracted/res/values-night/colors.xml

# Smali patching
sed -i 's/ff2b2a33/ff000000/g' ff-extracted/smali_classes2/mozilla/components/ui/colors/PhotonColors.smali
sed -i 's/ff42414d/ff15141a/g' ff-extracted/smali_classes2/mozilla/components/ui/colors/PhotonColors.smali
sed -i 's/ff52525e/ff15141a/g' ff-extracted/smali_classes2/mozilla/components/ui/colors/PhotonColors.smali

# Recompile the APK
java -jar apktool.jar b ff-extracted -o ff-patched.apk --use-aapt2

# Align and sign the APK
zipalign 4 ff-patched.apk ff-patched-signed.apk

# Clean up
rm -rf ff-extracted ff-patched.apk
