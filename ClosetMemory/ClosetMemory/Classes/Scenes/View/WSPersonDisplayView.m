//
//  WSPersonDisplayView.m
//  ClosetMemory
//
//  Created by 王顺 on 14-6-28.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "WSPersonDisplayView.h"

@implementation WSPersonDisplayView


- (void)dealloc
{
    [_collectionView release];
    [_flowLayout release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews
{

    self.flowLayout = [[UICollectionViewFlowLayout new] autorelease];
    _flowLayout.itemSize = CGSizeMake(100, 120);
    self.flowLayout.headerReferenceSize = CGSizeMake(K_MAINSCREEN_WIDTH, 100);
    self.collectionView = [[[UICollectionView alloc] initWithFrame:K_MAINSCREEN.bounds collectionViewLayout:_flowLayout] autorelease];
    self.collectionView.backgroundColor = K_MAINBACKGROUNDCOLOR;
    [self addSubview:_collectionView];
    
    [_collectionView release];

    
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
