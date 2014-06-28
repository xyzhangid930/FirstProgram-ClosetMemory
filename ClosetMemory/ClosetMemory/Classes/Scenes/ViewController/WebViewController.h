//
//  WebViewController.h
//  MushroomStreet
//
//  Created by LLLL on 14-5-26.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultList.h"

@interface WebViewController : UIViewController



@property (nonatomic, retain) ResultList *list;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSURLRequest *resquest;
- (NSURLRequest *)modelAttributeIndexPath:(NSIndexPath *)indexPath;
@end
