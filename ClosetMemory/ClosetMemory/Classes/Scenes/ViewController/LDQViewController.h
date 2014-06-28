//
//  LDQViewController.h
//  CloseMemory2
//
//  Created by lanou3g on 14-6-25.
//  Copyright (c) 2014年 吕东强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialControllerService.h"
#import "UMSocialShakeService.h"

//#pragma mark 声明一个协议
//@protocol getRemovedImageNameDelegate
//
//- (NSString *)getRemovedImageName:(NSString *)imageName;
//@end

@interface LDQViewController : UIViewController<
UIActionSheetDelegate,
UMSocialUIDelegate,
UMSocialShakeDelegate
>
@property (nonatomic, retain) NSString *className;
@property (nonatomic, retain) NSString *imagePath;
#pragma mark 声明一个代理属性
//@property (nonatomic, retain) id<getRemovedImageNameDelegate> delegate;
@end
