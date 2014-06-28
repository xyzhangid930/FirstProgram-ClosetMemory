//
//  OneViewController.h
//  Mushroom Street
//
//  Created by lanou3g on 14-5-29.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMQuiltView.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "DetailsViewController.h"
#import "DataRequest.h"
#import "ResultList.h"

@interface OneViewController : UIViewController<TMQuiltViewDataSource,TMQuiltViewDelegate,EGORefreshTableDelegate>
{
    EGORefreshTableHeaderView *_refreshTableHeader;     //上拉刷新
    EGORefreshTableFooterView *_refreshTableFooter;     //下拉加载
    BOOL _reloading;    //判断
    
}

@property (nonatomic, retain) NSString *mghStr;
@property (nonatomic, retain) TMQuiltView *tmQuiltView;
@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, retain) UILabel *info;


@end
