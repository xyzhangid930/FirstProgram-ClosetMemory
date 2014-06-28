//
//  ResultList.m
//  MushroomStreet
//
//  Created by LLLL on 14-5-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ResultList.h"

@implementation ResultList

- (void)dealloc
{
    [_cfav release];
    [_cforward release];
    [_content release];
    [_created release];
    [_creply release];
    [_isfaved release];
    [_show release];
    [_showContent release];
    [_showLarge release];
    [_photo release];
    [_trackld release];
    [_twitterld release];
    [_user release];
    [_tags release];
    [_single release];
    [super dealloc];
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
