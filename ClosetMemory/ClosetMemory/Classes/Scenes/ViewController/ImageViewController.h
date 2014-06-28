//
//  ImageViewController.h
//  MushroomStreet
//
//  Created by LLLL on 14-5-24.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultList.h"

@interface ImageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) ResultList *resultList;

@end
