//
//  ThereViewController.h
//  MushroomStreet
//
//  Created by LLLL on 14-5-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMQuiltView.h"
#import "DataRequest.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@interface ThereViewController : UIViewController<TMQuiltViewDataSource,TMQuiltViewDelegate,EGORefreshTableDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    
    BOOL _reloading;
    
}

@property (nonatomic, retain) TMQuiltView *tmquiltView;
@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) ResultList *resultList;
@property (nonatomic, retain) NSMutableArray *showImages;

@end
