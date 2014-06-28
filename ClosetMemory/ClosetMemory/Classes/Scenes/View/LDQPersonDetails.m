//
//  LDQPersonDetails.m
//  ClosetMemory
//
//  Created by lanou3g on 14-6-27.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "LDQPersonDetails.h"
#import "UIButton+myButton.h"

@implementation LDQPersonDetails

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addAllViews];
    }
    return self;
}
- (void)addAllViews
{
    self.tableView = [[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    [self addSubview:_tableView];
    
    self.lastView = [[UIView alloc]initWithFrame:CGRectMake(0, K_MAINSCREEN_HEIGHT - 40, K_MAINSCREEN_WIDTH, 2 * KWidth)];
    _lastView.backgroundColor = K_MAINBACKGROUNDCOLOR;
    [self addSubview:_lastView];
    self.shareButton = [UIButton buttonWithFrame:CGRectMake(KWidth, 0, KWidth, KWidth) Title:nil color:nil image:(UIImage *)@"iconfont-fenxiang.png"];
    
    [_lastView addSubview:_shareButton];
    self.deleteButton = [UIButton buttonWithFrame:CGRectMake(2.5 * KImageHeight, 0, KWidth, KWidth) Title:nil color:nil image:(UIImage *)@"iconfont-shanchu-3.png"];
    [_lastView addSubview:_deleteButton];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
