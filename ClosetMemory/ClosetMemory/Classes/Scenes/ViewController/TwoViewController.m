//
//  TwoViewController.m
//  Mushroom Street
//
//  Created by lanou3g on 14-5-29.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "TwoViewController.h"
#import "TMPhotoQuiltViewCell.h"
#import "UIImageView+WebCache.h"
@interface TwoViewController ()

@end

@implementation TwoViewController
- (void)dealloc
{
    [_tmquiltView release];
    [_label release];
    [_showArray release];
    [_refreshHeaderView release];
    [_refreshFooterView release];
    [_result release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //瀑布流
    _tmquiltView = [[TMQuiltView alloc]init];
    _tmquiltView.frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height - 44 - KHeight - KMargin);
    
    _tmquiltView.delegate = self;
    _tmquiltView.dataSource = self;
    [self.view addSubview:_tmquiltView];
    [_tmquiltView reloadData];
    
    //请求数据
    NSString *str = @"http://www.mogujie.com/app_mgj_v561_photo/qiaodastyle?_swidth=480&_uid=12kfq6c&timestamp=1401353795&_atype=android&_mgj=790f653c62dd7f1c48cf5f8600d533dc1401353795&_sdklevel=15&_msys=4.0.4&_network=2&_saveMode=0&sign=NchP4vGPCAcypgfFVqsa%2Fxp66R4TFyadKXvRg%2FgSnmHek%2Fj%2FZvwwV9e3W82HE0kYb4t%2FImI61%2FFglyZSXmM7fA%3D%3D&_fs=MAMwandoujia561&mbook=eyJwYWdlIjoyLCJzb3J0IjoibmV3IiwiYWN0aW9uIjoic3R5bGUiLCJpc1N0eWxlTGlzdCI6ZmFsc2UsInR5cGUiOiJhbGwiLCJ6dGFiIjo1LCJmcm9udFRhZ0lkIjpudWxsLCJwZXJzb25UeXBlIjoicWlhb2RhIiwidHlwZUlkIjpudWxsLCJjaGFubmVsIjoiYXBwIiwicGVycGFnZSI6MzB9&_did=869394014155649&_source=MAMwandoujia561&_minfo=ZTE%2BU807";
    NSURL *url = [NSURL URLWithString:str];
    
    
    [self refreshData:url];
    [self createHeaderView];
    [self performSelector:@selector(testFinishedLoadData) withObject:nil afterDelay:0.0f];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
//初始化刷新视图
//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark
#pragma methods for creating and removing the header view

-(void)createHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
	_refreshHeaderView = [[[EGORefreshTableHeaderView alloc] initWithFrame:
                           CGRectMake(0.0f, 0.0f - self.view.bounds.size.height,
                                      self.view.frame.size.width, self.view.bounds.size.height)]autorelease];
    _refreshHeaderView.delegate = self;
    
	[_tmquiltView addSubview:_refreshHeaderView];
    
    [_refreshHeaderView refreshLastUpdatedDate];
}

-(void)testFinishedLoadData{
    [self finishReloadingData];
    [self setFooterView];
}

#pragma mark -
#pragma mark method that should be called when the refreshing is finished
- (void)finishReloadingData{
	
	//  model should call this when its done loading
	_reloading = NO;
    
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tmquiltView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:_tmquiltView];
        //        [self setFooterView];
    }
    
    
}

-(void)setFooterView{
    CGFloat height = MAX(_tmquiltView.contentSize.height, _tmquiltView.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview])
	{
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              _tmquiltView.frame.size.width,
                                              self.view.bounds.size.height);
    } else {
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         _tmquiltView.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [_tmquiltView addSubview:_refreshFooterView];
    }
    
    if (_refreshFooterView)
	{
        [_refreshFooterView refreshLastUpdatedDate];
    }
}


-(void)removeFooterView
{
    if (_refreshFooterView && [_refreshFooterView superview])
	{
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}

//===============
//刷新delegate
#pragma mark -
#pragma mark data reloading methods that must be overide by the subclass

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
	
	_reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader)
	{
        [self performSelector:@selector(refreshView) withObject:nil afterDelay:2.0];
    }else if(aRefreshPos == EGORefreshFooter)
	{
        
        [self performSelector:@selector(getNextPageView) withObject:nil afterDelay:2.0];
    }
	
}

//刷新调用的方法
-(void)refreshView
{
	NSLog(@"刷新完成");
    
    NSString *str = @"http://www.mogujie.com/app_mgj_v561_photo/qiaodastyle?_swidth=480&_uid=12kfq6c&timestamp=1401353795&_atype=android&_mgj=790f653c62dd7f1c48cf5f8600d533dc1401353795&_sdklevel=15&_msys=4.0.4&_network=2&_saveMode=0&sign=NchP4vGPCAcypgfFVqsa%2Fxp66R4TFyadKXvRg%2FgSnmHek%2Fj%2FZvwwV9e3W82HE0kYb4t%2FImI61%2FFglyZSXmM7fA%3D%3D&_fs=MAMwandoujia561&mbook=eyJwYWdlIjoyLCJzb3J0IjoibmV3IiwiYWN0aW9uIjoic3R5bGUiLCJpc1N0eWxlTGlzdCI6ZmFsc2UsInR5cGUiOiJhbGwiLCJ6dGFiIjo1LCJmcm9udFRhZ0lkIjpudWxsLCJwZXJzb25UeXBlIjoicWlhb2RhIiwidHlwZUlkIjpudWxsLCJjaGFubmVsIjoiYXBwIiwicGVycGFnZSI6MzB9&_did=869394014155649&_source=MAMwandoujia561&_minfo=ZTE%2BU807";
    NSURL *url = [NSURL URLWithString:str];
    [self refreshData:url];
    [self testFinishedLoadData];
	
}
//加载调用的方法
-(void)getNextPageView
{
    
    NSURL *url = [NSURL URLWithString:@"http://www.mogujie.com/app_mgj_v561_photo/qiaodastyle?_swidth=540&timestamp=1400400970&_atype=android&_mgj=e27effd8a023c17bfd6c26de7a3be56e1400400970&_sdklevel=17&_msys=4.2.2&_network=2&_saveMode=0&_fs=MAMbaidu561&_did=356131050460529&_source=MAMbaidu561&_minfo=GT-I9158"];
	[self refreshData:url];
    [_tmquiltView reloadData];
    [self removeFooterView];
    [self testFinishedLoadData];
}
//刷新调用
- (void)refreshData:(NSURL *)url
{
    
//    NSURLRequest *urlRequest = [[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReturnCacheDataDontLoad timeoutInterval:15]autorelease];
//    NSOperationQueue *queue = [[[NSOperationQueue alloc]init]autorelease];
//    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        NSError *err = nil;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
//        self.showArray = [NSMutableArray arrayWithCapacity:10];
//        
//        NSArray *list = [[dic objectForKey:@"result"]objectForKey:@"list"];
//        
//        for (NSDictionary *item in list) {
//            
//            ResultList *resultList = [[ResultList alloc]init];
//            [resultList setValuesForKeysWithDictionary:item];
//            
//            [self.showArray addObject:resultList];
//            [resultList release];
//        }
//        
//        [_tmquiltView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
//    }];
    
}

- (NSMutableArray *)showArray
{
    if (!_showArray) {
        NSURL *url = [NSURL URLWithString:@"http://www.mogujie.com/app_mgj_v561_photo/qiaodastyle?_swidth=480&_uid=12kfq6c&timestamp=1401353795&_atype=android&_mgj=790f653c62dd7f1c48cf5f8600d533dc1401353795&_sdklevel=15&_msys=4.0.4&_network=2&_saveMode=0&sign=NchP4vGPCAcypgfFVqsa%2Fxp66R4TFyadKXvRg%2FgSnmHek%2Fj%2FZvwwV9e3W82HE0kYb4t%2FImI61%2FFglyZSXmM7fA%3D%3D&_fs=MAMwandoujia561&mbook=eyJwYWdlIjoyLCJzb3J0IjoibmV3IiwiYWN0aW9uIjoic3R5bGUiLCJpc1N0eWxlTGlzdCI6ZmFsc2UsInR5cGUiOiJhbGwiLCJ6dGFiIjo1LCJmcm9udFRhZ0lkIjpudWxsLCJwZXJzb25UeXBlIjoicWlhb2RhIiwidHlwZUlkIjpudWxsLCJjaGFubmVsIjoiYXBwIiwicGVycGFnZSI6MzB9&_did=869394014155649&_source=MAMwandoujia561&_minfo=ZTE%2BU807"];
        NSURLRequest *request = [[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15]autorelease];
        NSOperationQueue *queue = [[[NSOperationQueue alloc]init]autorelease];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            NSMutableArray *array = [NSMutableArray array];
            NSError *err = nil;
            //            self.showArray = [NSMutableArray arrayWithCapacity:10];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
            
            NSArray *list = [[dic objectForKey:@"result"]objectForKey:@"list"];
            
            for (NSDictionary *item in list) {
                
                ResultList *resultList = [[ResultList alloc]init];
                [resultList setValuesForKeysWithDictionary:item];
                
                [array addObject:resultList];
                self.showArray = [array retain];
                [resultList release];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tmquiltView reloadData];
            });
            
        }];
    }
    return _showArray;
    
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (_refreshHeaderView)
	{
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
	
	if (_refreshFooterView)
	{
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (_refreshHeaderView)
	{
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	
	if (_refreshFooterView)
	{
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}


#pragma mark -
#pragma mark EGORefreshTableDelegate Methods

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
	
	[self beginToReloadData:aRefreshPos];
	
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view
{
	
	return [NSDate date]; // should return date data source was last changed
	
}
#pragma mark - TMQuiltViewDataSource
- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView
{
    return [self.showArray count];
}
- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath*)indexPath
{
    NSString *identiFinerStr = @"photoIdentifier";
    TMPhotoQuiltViewCell *cell = (TMPhotoQuiltViewCell *)[quiltView dequeueReusableCellWithReuseIdentifier:identiFinerStr];
    if (cell == nil) {
        cell = [[[TMPhotoQuiltViewCell alloc]initWithReuseIdentifier:identiFinerStr]autorelease];
        
    }
    ResultList *list = [self.showArray objectAtIndex:indexPath.row];
    NSString *imgUrl = [list.show objectForKey:@"img"];
    [cell.photoView setImageWithURL:[NSURL URLWithString:imgUrl]];
    //头像
    NSString *userImg = [list.user objectForKey:@"avatar"];
    [cell.userView setImageWithURL:[NSURL URLWithString:userImg]];
    
    cell.titleLabel.text = list.showContent;
    
    //用户名字
    cell.userLabel.text = [list.user objectForKey:@"uname"];
//
    return cell;
}

#pragma mark - TMQuiltViewDelegate

//列数
- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView
{
    return 2;
}
//cell高度
- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        return 350;
    } else {
        return 300;
    }
    
}

//点击事件
- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"当前第%d张图片",indexPath.row);
    ResultList *list = [self.showArray objectAtIndex:indexPath.row];
    DetailsViewController *detailVC = [[DetailsViewController alloc]init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    detailVC.resultList = list;
    
    
}



@end
