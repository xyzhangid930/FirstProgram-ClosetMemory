//
//  WSPersonModel.m
//  ClosetMemory
//
//  Created by wangshun on 14-6-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "WSPersonModel.h"

@implementation WSPersonModel

- (void)dealloc
{
    [_personImageName release];
    [_coatName release];
    [_coatName2 release];
    [_pantsName release];
    [_skirtName release];
    [_shoesName release];
    [_bagName release];
    [_accessoryName release];
    [_remarks release];
    [_mood release];
    
    [super dealloc];
}

@end
