#!/bin/bash

# ---
# Replace all gray colors in dark mode to pure black.

# Color patching
echo "[INFO] OLED PATCH: Patching colors.xml"
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
		sed -i 's/ff1c1b22/ff000000/g' "$sm"
		sed -i 's/ff2b2a33/ff000000/g' "$sm"
		sed -i 's/ff42414d/ff15141a/g' "$sm"
		sed -i 's/ff52525e/ff25232e/g' "$sm"
		sed -i 's/ff5b5b66/ff2d2b38/g' "$sm"
		sed -i 's/ff2a2a2e/ff000000/g' "$sm"
	fi
done

echo "[INFO] Pathcing CSS Files"
# Error page background
sed -i 's/--background-color: #15141a/--background-color: #000000/g'	'assets/low_and_medium_risk_error_style.css'
sed -i 's/background-color: #1c1b22/background-color: #000000/g'	'assets/extensions/readerview/readerview.css'
sed -i 's/mipmap\/ic_launcher_round/drawable\/ic_launcher_foreground/g' res/drawable-v23/splash_screen.xml
sed -i 's/160\.0dip/200\.0dip/g' res/drawable-v23/splash_screen.xml

# 2a292e
# 2a2a2e
# 15141a
