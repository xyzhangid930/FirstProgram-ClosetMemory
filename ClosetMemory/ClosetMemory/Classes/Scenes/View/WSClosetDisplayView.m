//
//  WSClosetDisplayView.m
//  ClosetMemory
//
//  Created by 王顺 on 14-6-25.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "WSClosetDisplayView.h"


@implementation WSClosetDisplayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)dealloc
{
    [_segmentControl release];
    [_collectionView release];
    [_flowLayout release];
    [super dealloc];
}


- (void)addAllViews
{
    NSArray *segArray = [NSArray arrayWithObjects:@"时间", @"颜色", @"季节", @"品牌", @"价格", nil];
    self.segmentControl = [[[UISegmentedControl alloc] initWithItems:segArray] autorelease];
    _segmentControl.frame = CGRectMake(0, 44, K_MAINSCREEN_WIDTH, 30);
    _segmentControl.backgroundColor = [UIColor whiteColor];
    _segmentControl.tintColor = K_MAINCOLOR;
    [self addSubview:_segmentControl];
    [_segmentControl release];
    
    self.flowLayout = [[UICollectionViewFlowLayout new] autorelease];
    self.flowLayout.itemSize = CGSizeMake(100, 120);
    self.flowLayout.headerReferenceSize = CGSizeMake(K_MAINSCREEN_WIDTH, 100);
    self.collectionView = [[[UICollectionView alloc] initWithFrame:CGRectMake(0, 74, K_MAINSCREEN_WIDTH, K_MAINSCREEN_HEIGHT - 74) collectionViewLayout:_flowLayout] autorelease];
    self.collectionView.backgroundColor = K_MAINBACKGROUNDCOLOR;
    [self addSubview:_collectionView];
    [_collectionView release];
    [_flowLayout release];

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
