# flt_telephony_info

get telephony info：

Android:based on TelephonyManager

iOS：based on [CoreTelephony](https://developer.apple.com/documentation/coretelephony)


## ENGLISH    |     [中文](https://github.com/RandyWei/flt_telephony_info/blob/master/README.md)

## Installation
```
//pub
dependencies:
  flt_telephony_info: ^lastest_version

//import
dependencies:
  flt_telephony_info:
    git:
      url: git://github.com/RandyWei/flt_telephony_info.git
```

## Android

  dataNetworkType Requires permission:android.permission.READ_PHONE_STATE

  deviceSoftwareVersion Requires permission:android.permission.READ_PHONE_STATE

  IMEI(International Mobile Equipment Identity)（imei）Requires permission:android.permission.READ_PHONE_STATE


  isDataEnabled
  Requires one of the following permissions:
  android.permission.ACCESS_NETWORK_STATE
  android.permission.MODIFY_PHONE_STATE

  line1Numbe）
  Requires one of the following permissions:
  android.permission.READ_PHONE_STATE
  android.permission.READ_SMS
  android.permission.READ_PHONE_NUMBERS

  MEID (Mobile Equipment Identifier)（meid） Requires permission:android.permission.READ_PHONE_STATE

  Network Access Identifier (NAI)  Requires permission:android.permission.READ_PHONE_STATE
```xml
<manifest
    ...
    xmlns:tools="http://schemas.android.com/tools" >
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <uses-permission android:name="android.permission.MODIFY_PHONE_STATE"/>
    <uses-permission android:name="android.permission.READ_SMS"/>
    <uses-permission android:name="android.permission.READ_PHONE_NUMBERS"/>
    ...
</manifest>
```
## Example

```dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flt_telephony_info/flt_telephony_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TelephonyInfo _info;

  @override
  void initState() {
    super.initState();
    getTelephonyInfo();
  }

  Future<void> getTelephonyInfo() async {
    TelephonyInfo info;
    try {
      info = await FltTelephonyInfo.info;
    } on PlatformException {}

    if (!mounted) return;

    setState(() {
      _info = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Phone Number: ${_info?.line1Number}\n'),
        ),
      ),
    );
  }
}

```

## Other
[Home Page](https://www.bughub.dev)
[Video Player Based On TxVodPlayer](https://pub.flutter-io.cn/packages/flt_video_player)