//
//  WSClothingModel.m
//  ClosetMemory
//
//  Created by wangshun on 14-6-18.
//  Copyright (c) 2014年 2014蓝鸥20班. All rights reserved.
//

#import "WSClothingModel.h"

@implementation WSClothingModel

- (void)dealloc
{
    [_imageName release];
    [_className release];
    [_subClassName release];
    [_season release];
    [_color release];
    [_price release];
    [_brand release];
    [_date release];
    [_remarks release];
    
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"类型%@, 子分类%@, 颜色%@, 价格%@, 季节%@", _className, _subClassName, _color, _price, _season];
}
@end
