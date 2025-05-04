#!/bin/bash

# ---
# Eanble about:config always

# From builder (org/mozilla/geckoview/GeckoRuntimeSettings$Builder.smali)
# Find public aboutConfigEnabled(Z)

sm1="smali_classes1/org/mozilla/geckoview/GeckoRuntimeSettings\$Builder.smali"
sm2="smali_classes2/org/mozilla/geckoview/GeckoRuntimeSettings\$Builder.smali"
sm3="smali_classes3/org/mozilla/geckoview/GeckoRuntimeSettings\$Builder.smali"
sm4="smali_classes4/org/mozilla/geckoview/GeckoRuntimeSettings\$Builder.smali"

for sm in $sm1 $sm2 $sm3 $sm4; do
	if [ -f "$sm" ]; then
		# Find line number of the method 'aboutConfigEnabled'
		line=$(grep -n 'aboutConfigEnabled' "$sm" | cut -d: -f1)

		# Insert 'const p1, true', after the method definition.
		# This will enable about:config by default.
		if [ -n "$line" ]; then
			# Insert the line after the method definition
			sed -i "${line}a\    const p1, 0x1" "$sm"
			echo "[INFO] Patching $sm"
		else
			echo "[ERROR] Method 'aboutConfigEnabled' not found in $sm"
		fi
	fi
done
