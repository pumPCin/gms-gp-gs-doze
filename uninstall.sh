#!/system/bin/sh

# GP-GS Doze
# Patches Google Play, Galaxy Store to be able to use battery optimization

# Remove Google Play, Galaxy Store from battery optimization
dumpsys deviceidle whitelist +com.android.vending &> $NULL
dumpsys deviceidle whitelist +com.sec.android.app.samsungapps &> $NULL

# Remove all module files after un-installation
rm -rf /data/adb/gp-gs-doze
