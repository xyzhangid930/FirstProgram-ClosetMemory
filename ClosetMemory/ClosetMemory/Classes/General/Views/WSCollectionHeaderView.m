//
//  WSCollectionHeaderView.m
//  ClosetMemory
//
//  Created by 王顺 on 14-6-26.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "WSCollectionHeaderView.h"

@implementation WSCollectionHeaderView

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    [_label release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.textColor = [UIColor whiteColor];
        _label.text = @"hehehe";
        [self addSubview:_label];
        [_label release];
    }
    return self;
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
