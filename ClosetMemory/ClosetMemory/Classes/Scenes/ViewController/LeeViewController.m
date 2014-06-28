//
//  LeeViewController.m
//  Mushroom Street
//
//  Created by lanou3g on 14-5-29.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "LeeViewController.h"

@interface LeeViewController ()

@end

@implementation LeeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"love"];
        //        self.
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)dealloc
{
    [_scrollView release];
    [_seg release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *items = @[@"搭配",@"晒货",@"明星"];
    _seg = [[UISegmentedControl alloc]initWithItems:items];
    _seg.frame = CGRectMake(0, 44, 320, 30);
    _seg.selectedSegmentIndex = 0;
    
    _seg.tintColor = K_MAINCOLOR;
    [self.view addSubview:_seg];
    [_seg release];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 74, 320, CGRectGetHeight([UIScreen mainScreen].bounds))];
    
    _scrollView.contentSize = CGSizeMake(320 * 3, CGRectGetHeight([UIScreen mainScreen].bounds));
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    //边界不能滑动
    _scrollView.bounces = NO;
    
    [self.view addSubview:_scrollView];
    
    [_seg addTarget:self action:@selector(seg:) forControlEvents:UIControlEventValueChanged];
	// Do any additional setup after loading the view.
    
    [self addChildViewControllers];
    
}

#pragma mark 隐藏导航栏上方系统时间、电池显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//索引 实行的具体方法
- (void)seg:(UISegmentedControl *)segment
{
    _scrollView.contentOffset = CGPointMake(320 * segment.selectedSegmentIndex, 0);
}

- (void)addChildViewControllers
{
    
    OneViewController *firstVC = [[[OneViewController alloc] init]autorelease];
    [self addChildViewController:firstVC];
    firstVC.view.frame = CGRectMake(0 , 0, 320, _scrollView.bounds.size.height);
    
    TwoViewController *secondVC = [[[TwoViewController alloc]init]autorelease];
    [self addChildViewController:secondVC];
    secondVC.view.frame = CGRectMake(320, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    ThereViewController *thereVC = [[[ThereViewController alloc]init]autorelease];
    [self addChildViewController:thereVC];
    thereVC.view.frame = CGRectMake(320*2, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    
    [_scrollView addSubview:firstVC.view];
    [_scrollView addSubview:secondVC.view];
    [_scrollView addSubview:thereVC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _seg.selectedSegmentIndex = scrollView.contentOffset.x / 320;
}

@end
