//
//  ZXYContactViewController.m
//  ClosetMemory
//
//  Created by zxy on 14-6-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ZXYContactViewController.h"
#import "ZXYContactView.h"

@interface ZXYContactViewController ()

@property (nonatomic, retain) ZXYContactView *contactView;

@end

@implementation ZXYContactViewController

- (void)dealloc
{
    [_contactView release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"联系我们";
    }
    return self;
}

- (void)loadView
{
    self.contactView = [[[ZXYContactView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view = _contactView;
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
