#!/data/adb/magisk/busybox sh
set -o standalone

set -x

# GMS-GP-GS Doze
# Patches Google Play Services, Google Play, Galaxy Store - apps and certain processes/services to be able to use battery optimization

# Check Android API
[ $API -ge 23 ] ||
 abort "- Unsupported API version: $API"

# Patch the XML and place the modified one to the original directory
ui_print "- Patching XML files"
{
APP1="\"com.google.android.gms"\"
APP2="\"com.android.vending"\"
APP3="\"com.sec.android.app.samsungapps"\"
PRM1="allow-in-power-save package=$APP1"
PRM2="allow-in-data-usage-save package=$APP1"
PRM3="allow-in-power-save-except-idle package=$APP2"
PRM4="allow-in-power-save package=$APP3"
NULL="/dev/null"
}
ui_print "- Finding system XML"
SYS_XML="$(
SXML="$(find /system_ext/* /system/* /product/* \
/vendor/* -type f -iname '*.xml' -print)"
for S in $SXML; do
if grep -qE "$PRM1|$PRM2|$PRM3|$PRM4" $ROOT$S 2> $NULL; then
echo "$S"
fi
done
)"

PATCH_SX() {
for SX in $SYS_XML; do
mkdir -p "$(dirname $MODPATH$SX)"
cp -af $ROOT$SX $MODPATH$SX
 ui_print "  Patching: $SX"
sed -i "/$PRM1/d;/$PRM2/d;/$PRM3/d;/$PRM4/d" $MODPATH/$SX
done

# Merge patched files under /system dir
for P in product vendor; do
if [ -d $MODPATH/$P ]; then
 ui_print "- Moving files to module dir"
mkdir -p $MODPATH/system/$P
mv -f $MODPATH/$P $MODPATH/system/
fi
done
}

# Search and patch any conflicting modules (if present)
# Search conflicting XML files
MOD_XML="$(
MXML="$(find /data/adb/* -type f -iname "*.xml" -print)"
for M in $MXML; do
if grep -qE "$PRM1|$PRM2|$PRM3|$PRM4" $M; then
echo "$M"
fi
done
)"

PATCH_MX() {
 ui_print "- Finding conflicting XML"
for MX in $MOD_XML; do
MOD="$(echo "$MX" | awk -F'/' '{print $5}')"
 ui_print "  $MOD: $MX"
sed -i "/$PRM1/d;/$PRM2/d;/$PRM3/d;/$PRM4/d" $MX
done
}

# Find and patch conflicting XML
PATCH_SX && PATCH_MX

FINALIZE() {
 ui_print "- Finalizing installation"

# Clean up
 ui_print "  Cleaning obsolete files"
find $MODPATH/* -maxdepth 0 \
! -name 'module.prop' \
! -name 'post-fs-data.sh' \
! -name 'service.sh' \
! -name 'system' \
-exec rm -rf {} \;

# Settings dir and file permission
 ui_print "  Settings permissions"
set_perm_recursive $MODPATH 0 0 0755 0755
}

# Final adjustment
FINALIZE
