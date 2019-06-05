import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flt_telephony_info/flt_telephony_info.dart';

void main() {
  const MethodChannel channel = MethodChannel('flt_telephony_info');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FltTelephonyInfo.info, '42');
  });
}
