import 'package:flt_telephony_info/flt_telephony_info.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: FutureBuilder<TelephonyInfo>(
              builder: (context, snapshot) =>
                  Text('Phone Number: ${snapshot.data?.line1Number}\n'),
              future: FltTelephonyInfo.info,
            ),
          ),
        ),
      );
}
