//
//  LDQPerosnDetailsViewController.h
//  ClosetMemory
//
//  Created by lanou3g on 14-6-27.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSClothingModel.h"
#import "UMSocialShakeService.h"
@interface LDQPerosnDetailsViewController : UIViewController<
UITableViewDataSource,
UITableViewDelegate,
UIActionSheetDelegate,
UMSocialUIDelegate,
UMSocialShakeDelegate>
@property (nonatomic, retain) NSMutableDictionary *clothDict;
@property (nonatomic, retain) NSString *imagePath;
//@property (nonatomic,retain) UIView *moreView;

@end
