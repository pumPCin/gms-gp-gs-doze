#!/data/adb/magisk/busybox sh
set -o standalone

# GMS-GP-GS Doze
# Patches Google Play Services, Google Play, Galaxy Store - apps and certain processes/services to be able to use battery optimization

(   
# Wait until boot completed
until [ $(resetprop sys.boot_completed) -eq 1 ] &&
[ -d /sdcard ]; do
sleep 60
done

# GMS components
APP1="com.google.android.gms"
GMS1="auth.managed.admin.DeviceAdminReceiver"
GMS2="mdm.receivers.MdmDeviceAdminReceiver"
NULL="/dev/null"

# Disable collective device administrators
for U in $(ls /data/user); do
for C in $GMS1 $GMS2 $GMS3; do
pm disable --user $U "$APP1/$APP1.$C" &> $NULL
done
done

# Add GMS-GP-GS to battery optimization
dumpsys deviceidle whitelist -com.google.android.gms &> $NULL
dumpsys deviceidle whitelist -com.android.vending &> $NULL
dumpsys deviceidle whitelist -com.sec.android.app.samsungapps &> $NULL
dumpsys deviceidle whitelist -com.samsung.android.app.updatecenter &> $NULL
dumpsys deviceidle whitelist -com.samsung.android.video &> $NULL

exit 0
)
