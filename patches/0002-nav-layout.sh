#!/bin/bash

# ---
# Change the layout of Tabs UI

# Move new tab button to center
sed -i 's/android:layout_gravity="end|bottom|center"/android:layout_gravity="center_horizontal|bottom|center"/g' res/layout/component_tabstray3_fab.xml
