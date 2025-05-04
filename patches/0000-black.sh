#!/bin/bash

# ---
# Replace all gray colors in dark mode to pure black.

# Color patching
sed -i 's/<color name="fx_mobile_layer_color_1">.*/<color name="fx_mobile_layer_color_1">#ff000000<\/color>/g' res/values-night/colors.xml
sed -i 's/<color name="fx_mobile_layer_color_2">.*/<color name="fx_mobile_layer_color_2">@color\/photonDarkGrey90<\/color>/g' res/values-night/colors.xml

# Smali patching
sed -i 's/ff2b2a33/ff000000/g' smali_classes2/mozilla/components/ui/colors/PhotonColors.smali
sed -i 's/ff42414d/ff15141a/g' smali_classes2/mozilla/components/ui/colors/PhotonColors.smali
sed -i 's/ff52525e/ff15141a/g' smali_classes2/mozilla/components/ui/colors/PhotonColors.smali

sed -i 's/ff2b2a33/ff000000/g' smali_classes3/mozilla/components/ui/colors/PhotonColors.smali
sed -i 's/ff42414d/ff15141a/g' smali_classes3/mozilla/components/ui/colors/PhotonColors.smali
sed -i 's/ff52525e/ff15141a/g' smali_classes3/mozilla/components/ui/colors/PhotonColors.smali
