# GMS-GP-GS Doze

## Overview
- Patches Google Play Services, Google Play, Galaxy Store - apps and certain processes/services to be able to use battery optimization
- Support API 23 or later

## Troubleshootings
- Command-line for check optimization (in general):   
There's a line written `Whitelist (except idle) system apps:` 
If `com.google.android.gms` line does not exist it means Google Play Services app is optimized.
If `com.android.vending` line does not exist it means Google Play app is optimized.
If `com.sec.android.app.samsungapps` line does not exist it means Galaxy Store app is optimized.
```
> su
> dumpsys deviceidle
```
- Command-line for fix delayed incoming messages issue:   
If delayed incoming messages issue still persist, move Google Play Services app to Not Optimized battery usage.
```
> su
> cd /data/data
> find . -type f -name '*gms*' -delete
```
- Command-line for disable Find My Device (optional):
```
> su
> pm disable com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver
```

## Credits
- [@topjohnwu](https://github.com/topjohnwu)   
Magisk - Magisk Module Template
- [@MrCarb0n](https://github.com/MrCarb0n)   
Script / syntax helper
- [@gloeyisk](https://github.com/gloeyisk)
Universal Gms Doze
