//
//  ZXYWebConnection.m
//  ClosetMemory
//
//  Created by zxy on 14-6-21.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ZXYWebConnection.h"
#import "Reachability.h"

static NSInteger flag = 0;

@implementation ZXYWebConnection

+ (BOOL) isNetworkEnabled
{
    BOOL bEnabled = FALSE;
    NSString *url = @"www.baidu.com";
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
    SCNetworkReachabilityFlags flags;
    
    bEnabled = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    if (bEnabled) {
        //        kSCNetworkReachabilityFlagsReachable：能够连接网络
        //        kSCNetworkReachabilityFlagsConnectionRequired：能够连接网络，但是首先得建立连接过程
        //        kSCNetworkReachabilityFlagsIsWWAN：判断是否通过蜂窝网覆盖的连接，比如EDGE，GPRS或者目前的3G.主要是区别通过WiFi的连接。
        BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
        BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        bEnabled = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
    }
    if (!bEnabled && flag == 0) {
        flag = 1;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的网络有问题、无法连接到 web 服务器" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    NSLog(@"-----------%d", bEnabled);
    return bEnabled;
}

@end
