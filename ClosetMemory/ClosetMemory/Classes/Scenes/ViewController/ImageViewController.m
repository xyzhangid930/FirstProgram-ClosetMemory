//
//  ImageViewController.m
//  MushroomStreet
//
//  Created by LLLL on 14-5-24.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//


#import "ImageViewController.h"
#import "PhotoCell.h"
#import "UIImageView+WebCache.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)dealloc
{
    [_scrollView release];
    [_resultList release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [self.view addGestureRecognizer:tab];

    UITableView *imageTableView = [[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain]autorelease];
    imageTableView.delegate = self;
    imageTableView.dataSource = self;
    imageTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:imageTableView];
    
    
    
	// Do any additional setup after loading the view.
}

//点击返回
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.resultList.photo count];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indexCell = @"cell";
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:indexCell];
    if (!cell) {
        cell = [[[PhotoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexCell]autorelease];
    }
    
//    NSString *strUrl = [[self.resultList.photo objectAtIndex:indexPath.row]objectForKey:@"img"];
//   
//    [cell.photoView setImageWithURL:[NSURL URLWithString:strUrl]];
    [cell setPhotoHeight:self.resultList index:indexPath];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *height = [[self.resultList.photo objectAtIndex:indexPath.row]objectForKey:@"h"];
    CGFloat h = [height floatValue];
    NSString *width = [[self.resultList.photo objectAtIndex:indexPath.row]objectForKey:@"w"];
    CGFloat w = [width floatValue];
    
    return h*(320/w);
}

@end
