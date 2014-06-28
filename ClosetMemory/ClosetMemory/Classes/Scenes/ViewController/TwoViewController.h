//
//  TwoViewController.h
//  Mushroom Street
//
//  Created by lanou3g on 14-5-29.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMQuiltView.h"
#import "DataRequest.h"
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "DetailsViewController.h"

@interface TwoViewController : UIViewController<TMQuiltViewDataSource,TMQuiltViewDelegate,EGORefreshTableDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    
    BOOL _reloading;
    
}

@property (nonatomic, retain) TMQuiltView *tmquiltView;
//@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) NSMutableArray *showArray;
@property (nonatomic, retain) ResultList *result;


@end
