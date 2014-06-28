//
//  ZXYAppDelegate.m
//  ClosetMemory
//
//  Created by zxy on 14-6-18.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ZXYAppDelegate.h"
#import "ZXYRootViewController.h"
#import "ZXYDBManager.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialConfig.h"

@implementation ZXYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [UMSocialData setAppKey:UmengAppkey];
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxd9a39c7122aa6516" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关
    [UMSocialConfig setSupportSinaSSO:YES appRedirectUrl:@"http://sns.whalecloud.com/sina2/callback"];
    
    [self setAllStyle];
    [[ZXYDBManager sharedDataManager] openDB];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLoad"] == NO) {
        [[ZXYDBManager sharedDataManager] createTable];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"饰品" withSubClassName:@"眼镜"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"饰品" withSubClassName:@"帽子"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"饰品" withSubClassName:@"耳环"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"饰品" withSubClassName:@"戒指"];
        
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"上衣" withSubClassName:@"T恤"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"上衣" withSubClassName:@"衬衫"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"上衣" withSubClassName:@"西装"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"上衣" withSubClassName:@"风衣"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"上衣" withSubClassName:@"针织衫"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"上衣" withSubClassName:@"卫衣"];
        
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"裤子" withSubClassName:@"短裤"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"裤子" withSubClassName:@"七分裤"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"裤子" withSubClassName:@"背带裤"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"裤子" withSubClassName:@"长裤"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"裤子" withSubClassName:@"运动裤"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"裤子" withSubClassName:@"哈伦裤"];
        
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"裙子" withSubClassName:@"背心裙"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"裙子" withSubClassName:@"公主裙"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"裙子" withSubClassName:@"百褶裙"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"裙子" withSubClassName:@"连衣裙"];
        
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"鞋" withSubClassName:@"凉鞋"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"鞋" withSubClassName:@"短靴"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"鞋" withSubClassName:@"平底鞋"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"鞋" withSubClassName:@"高跟鞋"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"鞋" withSubClassName:@"帆布鞋"];
        
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"包" withSubClassName:@"钱包"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"包" withSubClassName:@"手拿包"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"包" withSubClassName:@"化妆包"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"包" withSubClassName:@"双肩包"];
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:@"包" withSubClassName:@"单肩包"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLoad"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    ZXYRootViewController *rootVC = [ZXYRootViewController new];
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [rootVC release];
    self.window.rootViewController = rootNC;
    [rootNC release];

    NSLog(@"%@", KDocument);
    
    
    return YES;
}

- (void)setAllStyle
{
    [[UINavigationBar appearance] setBarTintColor:K_MAINCOLOR];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
