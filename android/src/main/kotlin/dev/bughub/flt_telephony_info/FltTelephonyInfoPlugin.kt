package dev.bughub.flt_telephony_info

import android.annotation.SuppressLint
import android.content.Context
import android.os.Build
import android.telephony.TelephonyManager
import androidx.core.content.ContextCompat
import androidx.core.content.PermissionChecker.PERMISSION_GRANTED
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class FltTelephonyInfoPlugin : FlutterPlugin, MethodCallHandler {
    private var context: Context? = null
    private var methodChannel: MethodChannel? = null

    @SuppressLint("MissingPermission")
    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getTelephonyInfo") {

            val telephonyManager =
                context!!.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager


//            if (ContextCompat.checkSelfPermission(context!!, android.Manifest.permission.ACCESS_COARSE_LOCATION) == PERMISSION_GRANTED
//                    && Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
//                Log.i("getTelephonyInfo", telephonyManager.allCellInfo.toString())
//            }

            val resultMap = HashMap<String, Any?>()

            /**
             * 当前电话状态
             *
             * {@link TelephonyManager#CALL_STATE_RINGING}
             * {@link TelephonyManager#CALL_STATE_OFFHOOK}
             * {@link TelephonyManager#CALL_STATE_IDLE}
             */
            resultMap["callState"] = telephonyManager.callState

            /**
             * Returns a constant indicating the radio technology (network type)
             * currently in use on the device for data transmission.
             *
             * If this object has been created with {@link #createForSubscriptionId}, applies to the given
             * subId. Otherwise, applies to {@link SubscriptionManager#getDefaultDataSubscriptionId()}
             *
             * <p>Requires Permission: {@link android.Manifest.permission#READ_PHONE_STATE READ_PHONE_STATE}
             * or that the calling app has carrier privileges (see {@link #hasCarrierPrivileges}).
             *
             * @return the network type
             *
             * @see #NETWORK_TYPE_UNKNOWN
             * @see #NETWORK_TYPE_GPRS
             * @see #NETWORK_TYPE_EDGE
             * @see #NETWORK_TYPE_UMTS
             * @see #NETWORK_TYPE_HSDPA
             * @see #NETWORK_TYPE_HSUPA
             * @see #NETWORK_TYPE_HSPA
             * @see #NETWORK_TYPE_CDMA
             * @see #NETWORK_TYPE_EVDO_0
             * @see #NETWORK_TYPE_EVDO_A
             * @see #NETWORK_TYPE_EVDO_B
             * @see #NETWORK_TYPE_1xRTT
             * @see #NETWORK_TYPE_IDEN
             * @see #NETWORK_TYPE_LTE
             * @see #NETWORK_TYPE_EHRPD
             * @see #NETWORK_TYPE_HSPAP
             */
            //网络类型
            if (ContextCompat.checkSelfPermission(
                    context!!,
                    android.Manifest.permission.READ_PHONE_STATE
                ) == PERMISSION_GRANTED
                && Build.VERSION.SDK_INT >= Build.VERSION_CODES.N
            ) {
                resultMap["dataNetworkType"] = telephonyManager.dataNetworkType
            }

            //软件版本
            if (ContextCompat.checkSelfPermission(
                    context!!,
                    android.Manifest.permission.READ_PHONE_STATE
                ) == PERMISSION_GRANTED
            )
                resultMap["deviceSoftwareVersion"] = telephonyManager.deviceSoftwareVersion

            //IMEI
            if (ContextCompat.checkSelfPermission(
                    context!!,
                    android.Manifest.permission.READ_PHONE_STATE
                ) == PERMISSION_GRANTED && Build.VERSION.SDK_INT >= Build.VERSION_CODES.O
                && Build.VERSION.SDK_INT < Build.VERSION_CODES.Q
            ) {
                resultMap["imei"] = telephonyManager.imei
            }

            //是否启用数据
            /**
             * Returns whether mobile data is enabled or not per user setting. There are other factors
             * that could disable mobile data, but they are not considered here.
             *
             * If this object has been created with {@link #createForSubscriptionId}, applies to the given
             * subId. Otherwise, applies to {@link SubscriptionManager#getDefaultDataSubscriptionId()}
             *
             * <p>Requires one of the following permissions:
             * {@link android.Manifest.permission#ACCESS_NETWORK_STATE ACCESS_NETWORK_STATE},
             * {@link android.Manifest.permission#MODIFY_PHONE_STATE MODIFY_PHONE_STATE}, or that the
             * calling app has carrier privileges (see {@link #hasCarrierPrivileges}).
             *
             * <p>Note that this does not take into account any data restrictions that may be present on the
             * calling app. Such restrictions may be inspected with
             * {@link ConnectivityManager#getRestrictBackgroundStatus}.
             *
             * @return true if mobile data is enabled.
             */
            if ((ContextCompat.checkSelfPermission(
                    context!!,
                    android.Manifest.permission.ACCESS_NETWORK_STATE
                ) == PERMISSION_GRANTED ||
                        ContextCompat.checkSelfPermission(
                            context!!,
                            android.Manifest.permission.MODIFY_PHONE_STATE
                        ) == PERMISSION_GRANTED)
                && Build.VERSION.SDK_INT >= Build.VERSION_CODES.O
            ) {
                resultMap["isDataEnabled"] = telephonyManager.isDataEnabled
            }

            //是否漫游
            resultMap["isNetworkRoaming"] = telephonyManager.isNetworkRoaming

            //是否支持短信
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                resultMap["isSmsCapable"] = telephonyManager.isSmsCapable
            }

            //是否支持音频
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
                resultMap["isVoiceCapable"] = telephonyManager.isVoiceCapable
            }


//            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//                telephonyManager.isWorldPhone
//            }

            //手机号码(不一定能获取到)
            if (ContextCompat.checkSelfPermission(
                    context!!,
                    android.Manifest.permission.READ_PHONE_STATE
                ) == PERMISSION_GRANTED
                || ContextCompat.checkSelfPermission(
                    context!!,
                    android.Manifest.permission.READ_SMS
                ) == PERMISSION_GRANTED
                || ContextCompat.checkSelfPermission(
                    context!!,
                    android.Manifest.permission.READ_PHONE_NUMBERS
                ) == PERMISSION_GRANTED
            )
                resultMap["line1Number"] = telephonyManager.line1Number

            //MEID
            if (ContextCompat.checkSelfPermission(
                    context!!,
                    android.Manifest.permission.READ_PHONE_STATE
                ) == PERMISSION_GRANTED
                && Build.VERSION.SDK_INT >= Build.VERSION_CODES.O
                && Build.VERSION.SDK_INT < Build.VERSION_CODES.Q
            ) {
                resultMap["meid"] = telephonyManager.meid
            }

            //NAI
            if (ContextCompat.checkSelfPermission(
                    context!!,
                    android.Manifest.permission.READ_PHONE_STATE
                ) == PERMISSION_GRANTED
                && Build.VERSION.SDK_INT >= Build.VERSION_CODES.P
            ) {
                resultMap["nai"] = telephonyManager.nai
            }

            /**
             * Returns the ISO country code equivalent of the MCC (Mobile Country Code) of the current
             * registered operator, or nearby cell information if not registered.
             * .
             * <p>
             * Note: Result may be unreliable on CDMA networks (use {@link #getPhoneType()} to determine
             * if on a CDMA network).
             */
            resultMap["networkCountryIso"] = telephonyManager.networkCountryIso

            /**
             * Returns the numeric name (MCC+MNC) of current registered operator.
             * <p>
             * Availability: Only when user is registered to a network. Result may be
             * unreliable on CDMA networks (use {@link #getPhoneType()} to determine if
             * on a CDMA network).
             */
            resultMap["networkOperator"] = telephonyManager.networkOperator

            /**
             * Returns the network specifier of the subscription ID pinned to the TelephonyManager. The
             * network specifier is used by {@link
             * android.net.NetworkRequest.Builder#setNetworkSpecifier(String)} to create a {@link
             * android.net.NetworkRequest} that connects through the subscription.
             *
             * @see android.net.NetworkRequest.Builder#setNetworkSpecifier(String)
             * @see #createForSubscriptionId(int)
             * @see #createForPhoneAccountHandle(PhoneAccountHandle)
             */
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                resultMap["networkSpecifier"] = telephonyManager.networkSpecifier
            }

            //网络类型
            resultMap["networkType"] = telephonyManager.networkType

            /**
             * Returns the alphabetic name of current registered operator.
             * <p>
             * Availability: Only when user is registered to a network. Result may be
             * unreliable on CDMA networks (use {@link #getPhoneType()} to determine if
             * on a CDMA network).
             */
            resultMap["networkOperatorName"] = telephonyManager.networkOperatorName

            //含有几张可用的SIM卡
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                resultMap["phoneCount"] = telephonyManager.phoneCount
            }

            /**
             * Returns a constant indicating the device phone type.  This
             * indicates the type of radio used to transmit voice calls.
             *
             * @see #PHONE_TYPE_NONE
             * @see #PHONE_TYPE_GSM
             * @see #PHONE_TYPE_CDMA
             * @see #PHONE_TYPE_SIP
             */
            resultMap["phoneType"] = telephonyManager.phoneType

//            if (ContextCompat.checkSelfPermission(context!!, android.Manifest.permission.READ_PHONE_STATE) == PERMISSION_GRANTED
//                    && Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//                resultMap["serviceState"] = telephonyManager.serviceState
//            }

            //运营商ID
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                resultMap["simCarrierId"] = telephonyManager.simCarrierId
            }

            //运营商名称
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                resultMap["simCarrierIdName"] = telephonyManager.simCarrierIdName
            }

            //SIM ISO

            resultMap["simCountryIso"] = telephonyManager.simCountryIso

            //运营商代码
            resultMap["simOperator"] = telephonyManager.simOperator

            //运营商名称
            resultMap["simOperatorName"] = telephonyManager.simOperatorName

            //SIM 序列号
            if (ContextCompat.checkSelfPermission(
                    context!!,
                    android.Manifest.permission.READ_PHONE_STATE
                ) == PERMISSION_GRANTED
                && Build.VERSION.SDK_INT < Build.VERSION_CODES.Q
            )
                resultMap["simSerialNumber"] = telephonyManager.simSerialNumber


            result.success(resultMap)
        } else {
            result.notImplemented()
        }
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        methodChannel = MethodChannel(binding.binaryMessenger, "bughub.dev/flt_telephony_info")
        methodChannel!!.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel!!.setMethodCallHandler(null)
    }
}
