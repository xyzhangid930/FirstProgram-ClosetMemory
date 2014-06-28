//
//  DetailsViewController.h
//  MushroomStreet
//
//  Created by LLLL on 14-5-22.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultList.h"

@interface DetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) ResultList *resultList;
@property (nonatomic, retain) NSURLRequest *resquest;


@end
