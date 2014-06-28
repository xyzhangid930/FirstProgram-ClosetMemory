//
//  WSClosetDisplayView.h
//  ClosetMemory
//
//  Created by 王顺 on 14-6-25.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSClosetDisplayView : UIView

@property (nonatomic, retain) UISegmentedControl *segmentControl;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;

@end
