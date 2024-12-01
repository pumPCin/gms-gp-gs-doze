#!/data/adb/magisk/busybox sh
set -o standalone

# GP-GS Doze
# Patches Google Play, Galaxy Store to be able to use battery optimization

(   
# Wait until boot completed
until [ $(resetprop sys.boot_completed) -eq 1 ] &&
[ -d /sdcard ]; do
sleep 100
done

# Add Google Play, Galaxy Store to battery optimization
dumpsys deviceidle whitelist -com.android.vending &> $NULL
dumpsys deviceidle whitelist -com.sec.android.app.samsungapps &> $NULL

exit 0
)
