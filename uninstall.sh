#!/system/bin/sh

# GMS-GP-GS Doze
# Patches Google Play Services, Google Play, Galaxy Store - apps and certain processes/services to be able to use battery optimization

# GMS components
APP1="com.google.android.gms"
GMS1="auth.managed.admin.DeviceAdminReceiver"
GMS2="mdm.receivers.MdmDeviceAdminReceiver"
NULL="/dev/null"

# Enable collective device administrators
for U in $(ls /data/user); do
for C in $GMS1 $GMS2; do
pm enable --user $U "$APP1/$APP1.$C" &> $NULL
done
done

# Remove GMS-GP-GS from battery optimization
dumpsys deviceidle whitelist +com.google.android.gms &> $NULL
dumpsys deviceidle whitelist +com.android.vending &> $NULL
dumpsys deviceidle whitelist +com.sec.android.app.samsungapps &> $NULL
dumpsys deviceidle whitelist +com.samsung.android.app.updatecenter &> $NULL
dumpsys deviceidle whitelist +com.samsung.android.video &> $NULL

exit 0
)

# Remove all module files after un-installation
rm -rf /data/adb/gms-gp-gs-doze
