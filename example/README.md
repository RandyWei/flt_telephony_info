# flt_telephony_info_example

Demonstrates how to use the flt_telephony_info plugin.

## 使用
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
根据需要添加以下其中权限

  当前使用中的网络数据类型（dataNetworkType）需要权限：android.permission.READ_PHONE_STATE

  设备的软件版本号（deviceSoftwareVersion）需要权限：android.permission.READ_PHONE_STATE

  IMEI(International Mobile Equipment Identity)（imei）需要权限：android.permission.READ_PHONE_STATE


  是否打开网络数据（isDataEnabled）
  需要以下两个权限之一：
  android.permission.ACCESS_NETWORK_STATE
  android.permission.MODIFY_PHONE_STATE

  手机号码（line1Number）
  需要以下权限之一：
  android.permission.READ_PHONE_STATE
  android.permission.READ_SMS
  android.permission.READ_PHONE_NUMBERS

  MEID (Mobile Equipment Identifier)（meid）需要权限：android.permission.READ_PHONE_STATE

  Network Access Identifier (NAI) 需要权限：android.permission.READ_PHONE_STATE
```xml
<manifest
    ...
    xmlns:tools="http://schemas.android.com/tools" >
    <!-- 权限示例 -->
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