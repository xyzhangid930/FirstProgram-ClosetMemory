//
//  LDQPerosnDetailsViewController.m
//  ClosetMemory
//
//  Created by lanou3g on 14-6-27.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "LDQPerosnDetailsViewController.h"
#import "LDQPersonDetails.h"
#import "WSClothingModel.h"
#import "WSPersonModel.h"
#import "ZXYDBManager.h"
#import "LDQViewController.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"

@interface LDQPerosnDetailsViewController ()

@property (nonatomic,retain) LDQPersonDetails *perosnDetailsView;
@end

@implementation LDQPerosnDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView
{
    self.perosnDetailsView = [[LDQPersonDetails alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _perosnDetailsView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.perosnDetailsView.tableView.delegate = self;
    self.perosnDetailsView.tableView.dataSource = self;
    self.title = @"详情";
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"查看所有" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.perosnDetailsView.tableView.frame = CGRectMake(0, 0, 320, K_MAINSCREEN_HEIGHT - 30);

    [_perosnDetailsView.shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_perosnDetailsView.deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
    //  跳转到所有人的界面
    NSLog(@"跳转到所有人界面");
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.clothDict.count + 4;
}

#pragma mark 每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 280;
            break;
        default:
            return 44;
            break;
    }
}
#pragma mark cell显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id] autorelease];
        //cell的选中状态
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    WSPersonModel *personModel = [[ZXYDBManager sharedDataManager] searchFromPersonModel:@"personImageName" withValue:self.imagePath];
    if (indexPath.row == 0) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:self.imagePath]];
    } else if (indexPath.row > 0 && indexPath.row <= _clothDict.count){
        NSString *clothName = _clothDict[_clothDict.allKeys[indexPath.row - 1]];
        WSClothingModel *cloth = [[ZXYDBManager sharedDataManager] searchOneDataWithImageName:clothName];
        if (cloth) {
            cell.imageView.image = [UIImage imageWithContentsOfFile:clothName];
            cell.textLabel.text = [NSString stringWithFormat:@"种类: %@ 品牌: %@ 价格: %@", cloth.className, cloth.brand, cloth.price];
        } else {
            cell.textLabel.text = @"该衣物已被删除";
        }
    } else if (indexPath.row == _clothDict.count + 1){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        cell.textLabel.text = [NSString stringWithFormat:@"日期: %@", [dateFormatter stringFromDate:personModel.imageDate]];
    } else if (indexPath.row == _clothDict.count + 2) {
        cell.textLabel.text = [NSString stringWithFormat:@"备注: %@", personModel.remarks];
    } else if (indexPath.row == _clothDict.count + 3) {
        cell.textLabel.text = [NSString stringWithFormat:@"心情: %@", personModel.mood];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0 && indexPath.row <= _clothDict.count) {
        NSString *clothName = _clothDict[_clothDict.allKeys[indexPath.row - 1]];
        WSClothingModel *cloth = [[ZXYDBManager sharedDataManager] searchOneDataWithImageName:clothName];
        if (cloth) {
            LDQViewController *browsVC = [[LDQViewController alloc] init];
            browsVC.className = cloth.className;
            browsVC.imagePath = cloth.imageName;
            [self.navigationController pushViewController:browsVC animated:YES];
        }
    }
}

#pragma mark shareButtonAction点击事件
- (void)shareButtonAction:(UIButton *)sender
{
    NSString *shareText = @"衣柜记忆";             //分享内嵌文字
    UIImage *shareImage = [UIImage imageWithContentsOfFile:self.imagePath];          //分享内嵌图片
    
    //如果得到分享完成回调，需要设置delegate为self
    [UMSocialSnsService presentSnsIconSheetView:self appKey:UmengAppkey shareText:shareText shareImage:shareImage shareToSnsNames:nil delegate:self];
}
#pragma mark 删除事件
- (void)deleteButtonAction:(UIButton *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确定要删除吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[ZXYDBManager sharedDataManager] deleteDataWithImageName:self.imagePath];
        NSFileManager *fileManeger = [NSFileManager defaultManager];
        [fileManeger removeItemAtPath:self.imagePath error:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark 隐藏导航栏上方系统时间、电池显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
