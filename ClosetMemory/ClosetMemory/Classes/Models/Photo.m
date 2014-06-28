//
//  Photo.m
//  MushroomStreet
//
//  Created by LLLL on 14-5-24.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (void)dealloc
{
    [_iid release];
    [_img release];
    [super dealloc];
}

@end
