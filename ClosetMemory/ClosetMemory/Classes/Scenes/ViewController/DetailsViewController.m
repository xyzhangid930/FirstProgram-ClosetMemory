//
//  DetailsViewController.m
//  MushroomStreet
//
//  Created by LLLL on 14-5-22.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "ImageCell.h"
#import "WearCell.h"
#import "ButtonCell.h"
#import "ImageViewController.h"
#import "WebViewController.h"


@interface DetailsViewController ()

@end

@implementation DetailsViewController
- (void)dealloc
{
    [_resultList release];
//    [_imageName release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        
        self.title = @"搭配详情";
       
        
//        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        // Custom initializaation
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *scrollview = [[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    scrollview.contentSize = CGSizeMake(320, 500);
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.directionalLockEnabled = YES;
    scrollview.showsVerticalScrollIndicator = NO;

    self.view = scrollview;

//    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(rightbar:)]autorelease];
    
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    
    
    

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//按钮点击
#pragma mark - button
- (void)rightbar:(UIBarButtonItem *)item
{
    NSLog(@"返回");
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.resultList.single count]+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

   
        if (indexPath.row == 0) {
            static NSString *indeftCell1 = @"cell1";
            ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:indeftCell1];
            if (cell == nil) {
                cell = [[[ImageCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indeftCell1]autorelease];
            }

        [cell setPhotoImage:self.resultList];
            return cell;
        
        }else if (indexPath.row > 0 & indexPath.row < [self.resultList.single count]+1){
            static NSString *indeftCell2 = @"cell2";
            WearCell *cell = [tableView dequeueReusableCellWithIdentifier:indeftCell2];
            if (cell == nil) {
                cell = [[[WearCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indeftCell2]autorelease];
                
            }
            NSLog(@"1111111++++++%d",indexPath.row);
            NSString *imgUrl = [[self.resultList.single objectAtIndex:(indexPath.row-1)]objectForKey:@"img"];
            
            [cell.imageView setImageWithURL:[NSURL URLWithString:imgUrl]];
            [cell setLabelText:self.resultList index:indexPath];
            return cell;
        }
        else if (indexPath.row >= [self.resultList.single count]+1 ){
            static NSString *indeftCell3 = @"cell3";
            ButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:indeftCell3];
            if (cell == nil) {
                cell = [[[ButtonCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indeftCell3]autorelease];
            }
            
            return cell;
        }
    
    return nil;
}
    


//自定义cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [ImageCell heighetForImageCell:self.resultList];
    }else if (indexPath.row > 0 & indexPath.row < [self.resultList.single count]+1){
        return 70;
    }
    else {
        return 30;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    

    
    if (indexPath.row == 0) {
        NSLog(@"图片");
       
        ImageViewController *iamgeVC = [[[ImageViewController alloc]init]autorelease];
        iamgeVC.resultList = self.resultList;
        iamgeVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:iamgeVC animated:YES completion:^{
            
        }];
//        [self.navigationController pushViewController:iamgeVC animated:NO];
        
        
    }else if(indexPath.row > 0 && indexPath.row < [self.resultList.single count]+1){
        NSLog(@"12345");
        NSString *strURL = [[self.resultList.single objectAtIndex:indexPath.row-1] objectForKey:@"url"];
        NSURL *url = [NSURL URLWithString:strURL];
        _resquest = [[[NSURLRequest alloc]initWithURL:url]autorelease];
        WebViewController *webVC = [[WebViewController alloc]init];
        webVC.list = self.resultList;
        webVC.resquest = _resquest;
        [webVC.webView loadRequest:_resquest];
        [self.navigationController pushViewController:webVC animated:YES];
        [webVC release];
        
    }else{
        NSLog(@"按钮");
    }
    
}


@end
