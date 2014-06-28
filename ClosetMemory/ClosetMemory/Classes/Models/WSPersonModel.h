//
//  WSPersonModel.h
//  ClosetMemory
//
//  Created by wangshun on 14-6-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSClothingModel.h"

@interface WSPersonModel : NSObject

@property (nonatomic, copy) NSString *personImageName;
@property (nonatomic, copy) NSString *coatName;
@property (nonatomic, copy) NSString *coatName2;
@property (nonatomic, copy) NSString *pantsName;
@property (nonatomic, copy) NSString *skirtName;
@property (nonatomic, copy) NSString *shoesName;
@property (nonatomic, copy) NSString *bagName;
@property (nonatomic, copy) NSString *accessoryName;
@property (nonatomic, retain) NSDate *imageDate;
@property (nonatomic, copy) NSString *remarks;
@property (nonatomic, copy) NSString *mood;

@end