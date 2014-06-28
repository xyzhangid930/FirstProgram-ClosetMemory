//
//  OneViewController.m
//  Mushroom Street
//
//  Created by lanou3g on 14-5-29.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "OneViewController.h"
#import "TMPhotoQuiltViewCell.h"
#import "UIImageView+WebCache.h"

@interface OneViewController ()

@end

@implementation OneViewController
- (void)dealloc
{
    [_tmQuiltView release];
    [_images release];
    [_refreshTableHeader release];
    [_refreshTableFooter release];
    [_mghStr release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        self.navigationController.navigationBarHidden = NO;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //瀑布流
    _tmQuiltView = [[TMQuiltView alloc]init];
    
    _tmQuiltView.frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height - 44 - KHeight - KMargin);
    _tmQuiltView.delegate = self;
    _tmQuiltView.dataSource = self;
    self.images = [NSMutableArray arrayWithCapacity:20];
    
    [self.view addSubview:_tmQuiltView];
    [_tmQuiltView reloadData];
    
    //请求数据
    NSURL *url = [NSURL URLWithString:@"http://www.mogujie.com/app_mgj_v561_photo/darenstyle?_swidth=540&timestamp=1400402121&_atype=android&_mgj=0c6d60544ae2f46ca32540b3c3bdc8c11400402129&_sdklevel=17&_msys=4.2.2&_network=2&_saveMode=0&_fs=MAMbaidu561&_did=356131050460529&_source=MAMbaidu561&_minfo=GT-I9158"];
    
    [self refreshData:url];
    //刷新数据
    [self createHeaderView];
    [self performSelector:@selector(testFinishedLoadData) withObject:nil afterDelay:0.0f];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//****************************
//初始化刷新视图
//****************************
#pragma mark
#pragma methods for creating and removing the header view

- (void)createHeaderView
{
    if (_refreshTableHeader && [_refreshTableHeader superview]) {
        [_refreshTableHeader removeFromSuperview];
    }
    _refreshTableHeader = [[[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f-self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)]autorelease];
    _refreshTableHeader.delegate = self;
    [_tmQuiltView addSubview:_refreshTableHeader];
    //刷新时间
    [_refreshTableHeader refreshLastUpdatedDate];
}

//测试刷新
- (void)testFinishedLoadData
{
    [self finishReloadingData];
    [self setFooterView];
}


#pragma mark -
#pragma mark method that should be called when the refreshing is finished

- (void)finishReloadingData
{
    _reloading = NO;
    if (_refreshTableHeader) {
        [_refreshTableHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_tmQuiltView];
    }
    if (_refreshTableFooter) {
        [_refreshTableFooter egoRefreshScrollViewDataSourceDidFinishedLoading:_tmQuiltView];
        //调用加载
        //        [self setFooterView];
    }
}

//下拉刷新
- (void)setFooterView{
    CGFloat height = MAX(_tmQuiltView.contentSize.height, _tmQuiltView.frame.size.height);
    if (_refreshTableFooter && [_refreshTableFooter superview]) {
        _refreshTableFooter.frame = CGRectMake(0.0f, height, _tmQuiltView.frame.size.width, self.view.bounds.size.height);
    }else
    {
        _refreshTableFooter = [[EGORefreshTableFooterView alloc]initWithFrame:CGRectMake(0.0f, height, _tmQuiltView.frame.size.width, self.view.bounds.size.height)];
        _refreshTableFooter.delegate = self;
        [_tmQuiltView addSubview:_refreshTableFooter];
    }
    if (_refreshTableFooter) {
        [_refreshTableFooter refreshLastUpdatedDate];
    }
}
//移除加载
- (void)removeFooterView
{
    if (_refreshTableFooter && [_refreshTableFooter superview]) {
        [_refreshTableFooter removeFromSuperview];
    }
    _refreshTableFooter = nil;
}
//===============
//刷新delegate
#pragma mark -
#pragma mark data reloading methods that must be overide by the subclass

- (void)beginToReloadData:(EGORefreshPos)refreshPos{
    _reloading = YES;
    if (refreshPos == EGORefreshHeader) {
        [self performSelector:@selector(refreshView) withObject:nil afterDelay:2.0];
    }else if (refreshPos == EGORefreshFooter){
        [self performSelector:@selector(getNextPageView) withObject:nil afterDelay:2.0];
    }
}
//刷新重新调用的方法
- (void)refreshView
{
    NSLog(@"刷新完成");
    self.mghStr = [NSString stringWithFormat:@"_mgj=0c6d60544ae2f46ca32540b3c3bdc8c1140040%d",arc4random()%100+1000];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.mogujie.com/app_mgj_v561_photo/darenstyle?_swidth=540&timestamp=1400402121&_atype=android&%@&_sdklevel=17&_msys=4.2.2&_network=2&_saveMode=0&_fs=MAMbaidu561&_did=356131050460529&_source=MAMbaidu561&_minfo=GT-I9158",_mghStr]];
    [self refreshData:url];
    [self testFinishedLoadData];
}

//加载调用的方法
- (void)getNextPageView
{
    NSString *mghStr = [NSString stringWithFormat:@"_mgj=0c6d60544ae2f46ca32540b3c3bdc8c1%d01000",arc4random()%1000+10000];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.mogujie.com/app_mgj_v561_photo/darenstyle?_swidth=540&timestamp=1400402121&_atype=android&%@&_sdklevel=17&_msys=4.2.2&_network=2&_saveMode=0&_fs=MAMbaidu561&_did=356131050460529&_source=MAMbaidu561&_minfo=GT-I9158",mghStr]];
    [self refreshData:url];
    [_tmQuiltView reloadData];
    [self removeFooterView];
    [self testFinishedLoadData];
}

- (NSMutableArray *)images
{
    if (!_images) {
        NSString *mghStr = [NSString stringWithFormat:@"_mgj=0c6d60544ae2f46ca32540b3c3bdc8c1%d01000",arc4random()%1000+10000];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.mogujie.com/app_mgj_v561_photo/darenstyle?_swidth=540&timestamp=1400402121&_atype=android&%@&_sdklevel=17&_msys=4.2.2&_network=2&_saveMode=0&_fs=MAMbaidu561&_did=356131050460529&_source=MAMbaidu561&_minfo=GT-I9158",mghStr]];
        NSURLRequest *urlRequest = [[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:15]autorelease];
        NSOperationQueue *queue = [[[NSOperationQueue alloc]init]autorelease];
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            
            NSMutableArray *array = [NSMutableArray array];
            
            NSError *err = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
            NSArray *list = [[dic objectForKey:@"result"]objectForKey:@"list"];
            
            for (NSDictionary *item in list) {
                
                ResultList *resultList = [[ResultList alloc]init];
                [resultList setValuesForKeysWithDictionary:item];
                
                [array addObject:resultList];
                self.images = [array retain];
                [resultList release];
            }
            
            [_tmQuiltView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }];
        
    }
    
    return _images;
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_refreshTableHeader) {
        [_refreshTableHeader egoRefreshScrollViewDidScroll:scrollView];
    }
    if (_refreshTableFooter) {
        [_refreshTableFooter egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_refreshTableHeader) {
        [_refreshTableHeader egoRefreshScrollViewDidEndDragging:scrollView];
        
    }
    if (_refreshTableFooter) {
        [_refreshTableFooter egoRefreshScrollViewDidEndDragging:scrollView];
    }
}
#pragma mark -
#pragma mark EGORefreshTableDelegate Methods

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
    [self beginToReloadData:aRefreshPos];
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView *)view
{
    return _reloading;
}

- (NSDate *)egoRefreshTableDataSourceLastUpdated:(UIView *)view
{
    return [NSDate date];
}

//*****************************************************************




#pragma mark - TMQuiltViewDataSource

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView
{
    return [self.images count];
}
- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identiFierStr = @"photoIdentifier";
    TMPhotoQuiltViewCell *cell = (TMPhotoQuiltViewCell *)[quiltView dequeueReusableCellWithReuseIdentifier:identiFierStr];
    if (cell == nil) {
        cell = [[[TMPhotoQuiltViewCell alloc]initWithReuseIdentifier:identiFierStr]autorelease];
        
    }
    
    ResultList *resultList = [self.images objectAtIndex:indexPath.row];
    
    
    //大图图片
    NSString *imgeUrl = [resultList.show objectForKey:@"img"];
    [cell.photoView setImageWithURL:[NSURL URLWithString:imgeUrl]];
    
    //头像
    NSString *userImg = [resultList.user objectForKey:@"avatar"];
    [cell.userView setImageWithURL:[NSURL URLWithString:userImg]];
    
    
    
    
    cell.titleLabel.text = resultList.showContent;
    
    //用户名字
    cell.userLabel.text = [resultList.user objectForKey:@"uname"];
    
    return cell;
}

#pragma mark - TMQuiltViewDelegate

//列数
- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView
{
    return 2;
}

//单元高度
- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    //    float height = [self imageAtIndexPath:indexPath].size.height/[self quiltViewNumberOfColumns:quiltView];
    if (indexPath.row % 2 == 0) {
        return 350;
    } else {
        return 300;
    }
}
//点击事件
- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    ResultList *resultList = [self.images objectAtIndex:indexPath.row];
    DetailsViewController *detailVC = [[[DetailsViewController alloc]init]autorelease];
    [self.navigationController pushViewController:detailVC animated:YES];
    detailVC.resultList = resultList;
}

//刷新调用
- (void)refreshData:(NSURL *)url
{
    
    NSURLRequest *urlRequest = [[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:15]autorelease];
    NSOperationQueue *queue = [[[NSOperationQueue alloc]init]autorelease];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *err = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
        NSArray *list = [[dic objectForKey:@"result"]objectForKey:@"list"];
        
        for (NSDictionary *item in list) {
            
            ResultList *resultList = [[ResultList alloc]init];
            [resultList setValuesForKeysWithDictionary:item];
            
            [self.images addObject:resultList];
            [resultList release];
        }
        
        [_tmQuiltView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
    
}




@end
