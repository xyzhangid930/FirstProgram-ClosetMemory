//
//  UILabel+myLabel.m
//  CloseMemory2
//
//  Created by lanou3g on 14-6-21.
//  Copyright (c) 2014年 吕东强. All rights reserved.
//

#import "UILabel+myLabel.h"

@implementation UILabel (myLabel)

+(UIButton *)button1WithFrame:(CGRect)frame Title:(NSString *)title color:(UIColor *)color image:(NSString *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = color;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return button;
}

+(UILabel *)labelWithFrame:(CGRect)frame Text:(NSString *)text TextAlignment:(NSString *)textAlignment
{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}






@end
