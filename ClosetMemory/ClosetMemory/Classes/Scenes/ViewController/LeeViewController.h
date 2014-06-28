//
//  LeeViewController.h
//  Mushroom Street
//
//  Created by lanou3g on 14-5-29.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThereViewController.h"

@interface LeeViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    
}
@property (nonatomic, retain)  UISegmentedControl *seg;
@end
