//
//  ZXYAboutViewController.m
//  ClosetMemory
//
//  Created by zxy on 14-6-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ZXYAboutViewController.h"
#import "ZXYAboutView.h"

@interface ZXYAboutViewController ()

@property (nonatomic, retain) ZXYAboutView *aboutView;

@end

@implementation ZXYAboutViewController

- (void)dealloc
{
    [_aboutView release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"关于衣柜";
    }
    return self;
}

- (void)loadView
{
    self.aboutView = [[[ZXYAboutView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view = _aboutView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
