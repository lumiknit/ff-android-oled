#!/bin/bash

# ---
# Replace all gray colors in dark mode to pure black.

# Color patching
sed -i 's/<color name="fx_mobile_layer_color_1">.*/<color name="fx_mobile_layer_color_1">#ff000000<\/color>/g' res/values-night/colors.xml
sed -i 's/<color name="fx_mobile_layer_color_2">.*/<color name="fx_mobile_layer_color_2">@color\/photonDarkGrey90<\/color>/g' res/values-night/colors.xml

# Smali patching
sm1="smali/mozilla/components/ui/colors/PhotonColors.smali"
sm2="smali_classes2/mozilla/components/ui/colors/PhotonColors.smali"
sm3="smali_classes3/mozilla/components/ui/colors/PhotonColors.smali"
sm4="smali_classes4/mozilla/components/ui/colors/PhotonColors.smali"

for sm in $sm1 $sm2 $sm3 $sm4; do
	if [ -f "$sm" ]; then
		echo "[INFO] OLED PATCH: Patching $sm"
		sed -i 's/ff2b2a33/ff000000/g' "$sm"
		sed -i 's/ff42414d/ff15141a/g' "$sm"
		sed -i 's/ff52525e/ff15141a/g' "$sm"
	fi
done
