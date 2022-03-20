import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class FltTelephonyInfo {
  @visibleForTesting
  static const MethodChannel channel =
      const MethodChannel('bughub.dev/flt_telephony_info');

  static Future<TelephonyInfo> get info async => TelephonyInfo.fromMap(
      await channel.invokeMapMethod<String, dynamic>('getTelephonyInfo') ??
          const {});
}

class CallState {
  /// Device call state: No activity. */
  static const int CALL_STATE_IDLE = 0;

  /// Device call state: Ringing. A new call arrived and is
  ///  ringing or waiting. In the latter case, another call is
  ///  already active. */
  static const int CALL_STATE_RINGING = 1;

  /// Device call state: Off-hook. At least one call exists
  /// that is dialing, active, or on hold, and no calls are ringing
  /// or waiting. */
  static const int CALL_STATE_OFFHOOK = 2;
}

class NetworkType {
  /// Network type is unknown */
  static const int NETWORK_TYPE_UNKNOWN = 0;

  /// Current network is GPRS */
  static const int NETWORK_TYPE_GPRS = 1;

  /// Current network is EDGE */
  static const int NETWORK_TYPE_EDGE = 2;

  /// Current network is UMTS */
  static const int NETWORK_TYPE_UMTS = 3;

  /// Current network is CDMA: Either IS95A or IS95B*/
  static const int NETWORK_TYPE_CDMA = 4;

  /// Current network is EVDO revision 0*/
  static const int NETWORK_TYPE_EVDO_0 = 5;

  /// Current network is EVDO revision A*/
  static const int NETWORK_TYPE_EVDO_A = 6;

  /// Current network is 1xRTT*/
  static const int NETWORK_TYPE_1xRTT = 7;

  /// Current network is HSDPA */
  static const int NETWORK_TYPE_HSDPA = 8;

  /// Current network is HSUPA */
  static const int NETWORK_TYPE_HSUPA = 9;

  /// Current network is HSPA */
  static const int NETWORK_TYPE_HSPA = 10;

  /// Current network is iDen */
  static const int NETWORK_TYPE_IDEN = 11;

  /// Current network is EVDO revision B*/
  static const int NETWORK_TYPE_EVDO_B = 12;

  /// Current network is LTE */
  static const int NETWORK_TYPE_LTE = 13;

  /// Current network is eHRPD */
  static const int NETWORK_TYPE_EHRPD = 14;

  /// Current network is HSPA+ */
  static const int NETWORK_TYPE_HSPAP = 15;

  /// Current network is GSM */
  static const int NETWORK_TYPE_GSM = 16;

  /// Current network is TD_SCDMA */
  static const int NETWORK_TYPE_TD_SCDMA = 17;

  /// Current network is IWLAN */
  static const int NETWORK_TYPE_IWLAN = 18;

  /// Current network is LTE_CA {@hide} */
  static const int NETWORK_TYPE_LTE_CA = 19;

  /// Max network type number. Update as new types are added. Don't add negative types. {@hide} */
  static const int MAX_NETWORK_TYPE = NETWORK_TYPE_LTE_CA;
}

class PhoneType {
  /// No phone radio. */
  static const int PHONE_TYPE_NONE = 0;

  /// Phone radio is GSM. */
  static const int PHONE_TYPE_GSM = 1;

  /// Phone radio is CDMA. */
  static const int PHONE_TYPE_CDMA = 2;

  /// Phone is via SIP. */
  static const int PHONE_TYPE_SIP = 3;
}

class TelephonyInfo {
  TelephonyInfo._({
    required this.callState,
    required this.dataNetworkType,
    required this.deviceSoftwareVersion,
    required this.imei,
    required this.isDataEnabled,
    required this.isNetworkRoaming,
    required this.isSmsCapable,
    required this.isVoiceCapable,
    required this.line1Number,
    required this.meid,
    required this.nai,
    required this.networkCountryIso,
    required this.networkOperator,
    required this.networkSpecifier,
    required this.networkType,
    required this.networkOperatorName,
    required this.phoneCount,
    required this.phoneType,
    required this.serviceState,
    required this.simCarrierId,
    required this.simCarrierIdName,
    required this.simCountryIso,
    required this.simOperator,
    required this.simOperatorName,
    required this.simSerialNumber,
  });

  ///当前电话状态
  ///返回值参考：[CallState]
  final int? callState;

  ///当前使用中的网络数据类型
  ///安卓需要权限：android.permission.READ_PHONE_STATE
  ///[NetworkType]
  final int? dataNetworkType;

  ///设备的软件版本号
  ///安卓需要权限：android.permission.READ_PHONE_STATE
  final String? deviceSoftwareVersion;

  ///IMEI(International Mobile Equipment Identity)
  ///安卓需要权限：android.permission.READ_PHONE_STATE
  final String? imei;

  ///是否打开网络数据
  ///安卓以下权限之一：
  ///android.permission.ACCESS_NETWORK_STATE
  ///android.permission.MODIFY_PHONE_STATE
  final bool? isDataEnabled;

  ///是否漫游
  final bool? isNetworkRoaming;

  ///是否支持短信
  final bool? isSmsCapable;

  ///是否支持语音通信
  final bool? isVoiceCapable;

  ///手机号码，获取不到将返回null
  ///安卓需要以下权限之一：
  ///android.permission.READ_PHONE_STATE
  ///android.permission.READ_SMS
  ///android.permission.READ_PHONE_NUMBERS
  final String? line1Number;

  ///MEID (Mobile Equipment Identifier)
  ///安卓需要权限：android.permission.READ_PHONE_STATE
  final String? meid;

  ///Network Access Identifier (NAI)
  ///安卓需要权限：android.permission.READ_PHONE_STATE
  final String? nai;

  ///当前网络所在国家代码
  final String? networkCountryIso;
  final String? networkOperator;
  final String? networkSpecifier;

  ///网络类型
  ///[NetworkType]
  final int? networkType;
  final String? networkOperatorName;

  ///可用的SIM卡数量
  final int? phoneCount;

  ///[PhoneType]
  final int? phoneType;
  final dynamic serviceState;
  final int? simCarrierId;

  ///运营商名称
  final String? simCarrierIdName;
  final String? simCountryIso;
  final String? simOperator;

  ///运营商名称
  final String? simOperatorName;
  final String? simSerialNumber;

  static TelephonyInfo fromMap(Map<String, dynamic> map) {
    return TelephonyInfo._(
      callState: map["callState"],
      dataNetworkType: map["dataNetworkType"],
      deviceSoftwareVersion: map["deviceSoftwareVersion"],
      imei: map["imei"],
      isDataEnabled: map["isDataEnabled"],
      isNetworkRoaming: map["isNetworkRoaming"],
      isSmsCapable: map["isSmsCapable"],
      isVoiceCapable: map["isVoiceCapable"],
      line1Number: map["line1Number"],
      meid: map["meid"],
      nai: map["nai"],
      networkCountryIso: map["networkCountryIso"],
      networkOperator: map["networkOperator"],
      networkSpecifier: map["networkSpecifier"],
      networkType: map["networkType"],
      networkOperatorName: map["networkOperatorName"],
      phoneCount: map["phoneCount"],
      phoneType: map["phoneType"],
      serviceState: map["serviceState"],
      simCarrierId: map["simCarrierId"],
      simCarrierIdName: map["simCarrierIdName"],
      simCountryIso: map["simCountryIso"],
      simOperator: map["simOperator"],
      simOperatorName: map["simOperatorName"],
      simSerialNumber: map["simSerialNumber"],
    );
  }

  @override
  String toString() {
    super.toString();
    return "{"
        "\ncallState:$callState,"
        "\ndataNetworkType:$dataNetworkType,"
        "\ndeviceSoftwareVersion:$deviceSoftwareVersion,"
        "\nimei:$imei,"
        "\nisDataEnabled:$isDataEnabled,"
        "\nisNetworkRoaming:$isNetworkRoaming"
        "\nisSmsCapable:$isSmsCapable,"
        "\nisVoiceCapable:$isVoiceCapable,"
        "\nline1Number:$line1Number,"
        "\nmeid:$meid,"
        "\nnai:$nai,"
        "\nnetworkCountryIso:$networkCountryIso,"
        "\nnetworkOperator:$networkOperator,"
        "\nnetworkSpecifier:$networkSpecifier,"
        "\nnetworkType:$networkType,"
        "\nnetworkOperatorName:$networkOperatorName,"
        "\nphoneCount:$phoneCount,"
        "\nphoneType:$phoneType,"
        "\nserviceState:$serviceState,"
        "\nsimCarrierId:$simCarrierId,"
        "\nsimCarrierIdName:$simCarrierIdName,"
        "\nsimCountryIso:$simCountryIso,"
        "\nsimOperator:$simOperator,"
        "\nsimOperatorName:$simOperatorName,"
        "\nsimSerialNumber:$simSerialNumber"
        "\n}";
  }
}
