#import "FltTelephonyInfoPlugin.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation FltTelephonyInfoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel
                                     methodChannelWithName:@"bughub.dev/flt_telephony_info"
                                     binaryMessenger:[registrar messenger]];
    FltTelephonyInfoPlugin *instance = [[FltTelephonyInfoPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"getTelephonyInfo" isEqualToString:call.method]) {
        CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];

        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

        CTCarrier *carrier = networkInfo.subscriberCellularProvider;

        //运营商名称
        NSString *carrierName= carrier.carrierName;
        if (carrierName != nil) {
            dict[@"simCarrierIdName"] = carrierName;
        }

        NSMutableString *operator = [[NSMutableString alloc] init];
        //国家编号
        NSString *mobileCountryCode = carrier.mobileCountryCode;
        //运营商网络编号
        NSString *mobileNetworkCode = carrier.mobileNetworkCode;

        if (mobileCountryCode!=NULL) {
            [operator appendFormat:@"%@", mobileCountryCode];
        }
        if (mobileNetworkCode!=NULL) {
            [operator appendFormat:@"%@", mobileNetworkCode];
        }

        dict[@"simOperator"] = operator;
        dict[@"networkOperator"] = operator;

        NSString *isoCountryCode = carrier.isoCountryCode;
        if (isoCountryCode != nil) {
            dict[@"simCountryIso"] = isoCountryCode;
            dict[@"networkCountryIso"] = isoCountryCode;
        }
        dict[@"isVoiceCapable"] = @(carrier.allowsVOIP);


        //只能获取的是机主设置的本机号码，不能读取sim卡上的电话号码
        NSString *number = [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
        if (number != nil) {
            dict[@"line1Number"] = number;
        }
        result(dict);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
