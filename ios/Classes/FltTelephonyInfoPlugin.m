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

        dict[@"dataNetworkType"]=@0;
        NSString *dataNetworkType= networkInfo.currentRadioAccessTechnology;
        if ([dataNetworkType isEqualToString:CTRadioAccessTechnologyGPRS]) {
            dict[@"dataNetworkType"]=@1;
        } else if ([dataNetworkType isEqualToString:CTRadioAccessTechnologyEdge]) {
            dict[@"dataNetworkType"]=@2;
        } else if ([dataNetworkType isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
            dict[@"dataNetworkType"]=@3;
        } else if ([dataNetworkType isEqualToString:CTRadioAccessTechnologyWCDMA]) {
            dict[@"dataNetworkType"]=@4;
        } else if ([dataNetworkType isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]) {
            dict[@"dataNetworkType"]=@5;
        } else if ([dataNetworkType isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]) {
            dict[@"dataNetworkType"]=@6;
        } else if ([dataNetworkType isEqualToString:CTRadioAccessTechnologyHSDPA]) {
            dict[@"dataNetworkType"]=@8;
        } else if ([dataNetworkType isEqualToString:CTRadioAccessTechnologyHSUPA]) {
            dict[@"dataNetworkType"]=@9;
        } else if ([dataNetworkType isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]) {
            dict[@"dataNetworkType"]=@12;
        } else if ([dataNetworkType isEqualToString:CTRadioAccessTechnologyLTE]) {
            dict[@"dataNetworkType"]=@13;
        } else if ([dataNetworkType isEqualToString:CTRadioAccessTechnologyeHRPD]) {
            dict[@"dataNetworkType"]=@14;
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
