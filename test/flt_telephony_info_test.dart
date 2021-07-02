import 'package:flt_telephony_info/flt_telephony_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    FltTelephonyInfo.channel
        .setMockMethodCallHandler((methodCall) async => {'simCarrierId': 42});
  });

  tearDown(() {
    FltTelephonyInfo.channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect((await FltTelephonyInfo.info).simCarrierId, 42);
  });
}
