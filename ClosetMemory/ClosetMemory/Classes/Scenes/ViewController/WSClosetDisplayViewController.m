//
//  WSClosetDisplayViewController.m
//  ClosetMemory
//
//  Created by 王顺 on 14-6-25.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

static NSString *cell_id = @"cell_id";
static NSString *headView_id = @"headView_id";
#import "WSClosetDisplayViewController.h"
#import "WSClosetDisplayView.h"
#import "WSCollectionViewCell.h"
#import "ZXYDBManager.h"
#import "WSCollectionHeaderView.h"

@interface WSClosetDisplayViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate>

@property (nonatomic, retain)WSClosetDisplayView *closetDisplayView;
//@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation WSClosetDisplayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.closetDisplayView = [[WSClosetDisplayView alloc] initWithFrame:K_MAINSCREEN.bounds];
    self.view = _closetDisplayView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _closetDisplayView.collectionView.dataSource = self;
    _closetDisplayView.collectionView.delegate = self;
    _closetDisplayView.segmentControl.selectedSegmentIndex = 1;
    [self analysizeData:1];
    [_closetDisplayView.segmentControl addTarget:self
                                          action:@selector(segmentControlChangeSelectedIndexAction:)
                                forControlEvents:UIControlEventValueChanged];
    //  注册cell;
    [_closetDisplayView.collectionView registerClass:[WSCollectionViewCell class]
                 forCellWithReuseIdentifier:cell_id];
    //  注册header
    [_closetDisplayView.collectionView registerClass:[WSCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headView_id];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UICollectionViewDataSource Methods
#pragma mark 设置每个分组中有多少个item

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSLog(@"section%d", _dataDictionary.count);
    return self.dataDictionary.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"array%d", [_dataDictionary[_keyArray[section]] count]);
    return [self.dataDictionary[self.keyArray[section]] count];
}


#pragma mark 设置每个item上显示内容

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //  2.首先从重用队列中查找
    WSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id
                                                                           forIndexPath:indexPath];
    //  4.复制信息
    WSClothingModel *clothing = _dataDictionary[_keyArray[indexPath.section]][indexPath.row];
    cell.imageView.image = [UIImage imageWithContentsOfFile:clothing.imageName];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.layer.borderWidth = 5;
//    cell.imageView.layer.borderColor = [[ZXYDBManager sharedDataManager]getColorFromString:[clothing.color substringToIndex:1]].CGColor;
//    cell.label.text = [self clothing];
    return cell;
}


#pragma mark 设置每个item 的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100 * 9.f/ 7.f);
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    WSAlbumViewController *albumVC = [WSAlbumViewController new];
//    albumVC.imageArray = _imageArray;
//    albumVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    albumVC.numberOfPicture = indexPath.row;
//    [self presentViewController:albumVC animated:YES completion:nil];
//    
//}

#pragma mark 设置每个标题头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ;
    WSCollectionHeaderView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headView_id forIndexPath:indexPath];
    if (self.closetDisplayView.segmentControl.selectedSegmentIndex == 1)
    {
        headView.backgroundColor = [[ZXYDBManager sharedDataManager] getColorFromString:self.keyArray[indexPath.section]];
    }
    else
    {
        headView.backgroundColor = K_MAINCOLOR;
    }
    headView.label.text = self.keyArray[indexPath.section];
    NSLog(@"...%@", headView.label.text);
    NSLog(@"%p,%p",headView,headView.label);

    return headView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(K_MAINSCREEN_WIDTH, 30);
}

- (void)analysizeData:(NSInteger)selectedIndex
{
    
    switch (selectedIndex) {
            //@"时间", @"颜色", @"季节", @"品牌", @"价格"
        case 0: {
            self.dataDictionary = [[ZXYDBManager sharedDataManager] groupedClothingByDate];
            NSLog(@"%@", _dataDictionary);
            self.keyArray = [NSMutableArray arrayWithArray:[_dataDictionary allKeys]];
            [_keyArray sortUsingSelector:@selector(compare:)];
            [_keyArray removeObject:@"本月"];
            [_keyArray addObject:@"本月"];
            
        }
            break;
        case 1: {
            self.dataDictionary = [[ZXYDBManager sharedDataManager] groupedClothingByColor];
            self.keyArray = [NSMutableArray arrayWithArray:[_dataDictionary allKeys]];
            [_keyArray removeObject:@"未标注颜色"];
            [_keyArray addObject:@"未标注颜色"];
            
        }
            break;
        case 2: {
            self.dataDictionary = [[ZXYDBManager sharedDataManager] groupedClothingBySeason];
            self.keyArray = [NSMutableArray arrayWithObjects:@"春", @"夏", @"秋", @"冬", @"未标注季节", nil];
            
        }
            break;
        case 3: {
            self.dataDictionary = [[ZXYDBManager sharedDataManager] groupedClothingByBrand];
            self.keyArray = [NSMutableArray arrayWithArray:[_dataDictionary allKeys]];
            [_keyArray sortUsingSelector:@selector(compare:)];
            [_keyArray removeObject:@"未标注品牌"];
            [_keyArray addObject:@"未标注品牌"];
            
        }
            break;
        case 4: {
            self.dataDictionary = [[ZXYDBManager sharedDataManager] groupedClothingByPrice];
            self.keyArray = [NSMutableArray arrayWithArray:[_dataDictionary allKeys]];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)segmentControlChangeSelectedIndexAction:(UISegmentedControl *)sender
{
    
    [self analysizeData:sender.selectedSegmentIndex];
    [_closetDisplayView.collectionView reloadData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark 衣服命名
- (NSString *)clothingNameWith:(WSClothingModel *)clothing
{
    NSString *string = nil;
    if (clothing.color.length == 0) {
        if (clothing.subClassName.length == 0) {
            string = clothing.className;
        }else {
            string = clothing.subClassName;
        }
    }else if (clothing.color.length == 1) {
        if (clothing.subClassName.length == 0) {
            string = [NSString stringWithFormat:@"%@色的%@", clothing.color, clothing.className];
        }else {
            string = [NSString stringWithFormat:@"%@色的%@", clothing.color, clothing.subClassName];
        }
    }else {
        if (clothing.subClassName.length == 0) {
            string = [NSString stringWithFormat:@"%@相间的%@", clothing.color, clothing.className];
        }else {
            string = [NSString stringWithFormat:@"%@相间的%@", clothing.color, clothing.subClassName];
        }
    }
    return string;
}


#pragma mark 隐藏导航栏上方系统时间、电池显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
