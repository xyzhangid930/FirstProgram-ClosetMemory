//
//  UIButton+myButton.m
//  ClosetMemory
//
//  Created by lanou3g on 14-6-19.
//  Copyright (c) 2014年 2014蓝鸥20班. All rights reserved.
//

#import "UIButton+myButton.h"

@implementation UIButton (myButton)
+(UIButton *)buttonWithFrame:(CGRect)frame Title:(NSString *)title color:(UIColor *)color image:(NSString *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = color;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return button;
}

+(UIButton *)button1WithFrame:(CGRect)frame Title:(NSString *)title color:(UIColor *)color image:(NSString *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = color;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return button;
}

@end
