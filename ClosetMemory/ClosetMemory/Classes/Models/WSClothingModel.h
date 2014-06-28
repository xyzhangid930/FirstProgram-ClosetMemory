//
//  WSClothingModel.h
//  ClosetMemory
//
//  Created by wangshun on 14-6-18.
//  Copyright (c) 2014年 2014蓝鸥20班. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSClothingModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *subClassName;
@property (nonatomic, retain) NSString *season;
@property (nonatomic, retain) NSString *color;
@property (nonatomic, copy) NSString *brand;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, copy) NSString *remarks;

@end
