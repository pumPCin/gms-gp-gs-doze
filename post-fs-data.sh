#!/data/adb/magisk/busybox sh
set -o standalone

# GP-GS Doze
# Patches Google Play, Galaxy Store - apps and certain processes/services to be able to use battery optimization

# Search and patch any conflicting modules (if present)
{
APP1="\"com.android.vending"\"
APP2="\"com.sec.android.app.samsungapps"\"
PRM1="allow-in-power-save package=$APP1"
PRM2="allow-in-power-save-except-idle package=$APP1"
PRM3="allow-in-data-usage-save package=$APP1"
PRM4="allow-in-power-save package=$APP2"
PRM5="allow-in-power-save-except-idle package=$APP2"
PRM6="allow-in-data-usage-save package=$APP2"
NULL="/dev/null"
}

{
find /data/adb/* -type f -iname "*.xml" -print |
while IFS= read -r XML; do
for X in $XML; do
if grep -qE "$PRM1|$PRM2|$PRM3|$PRM4|$PRM5|$PRM6" $X 2> $NULL; then
sed -i "/$PRM1/d;/$PRM2/d;/$PRM3/d;/$PRM4/d;/$PRM5/d;/$PRM6/d" $X
fi
done
done
}
