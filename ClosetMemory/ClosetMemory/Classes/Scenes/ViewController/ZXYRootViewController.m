//
//  ZXYRootViewController.m
//  ClosetMemory
//
//  Created by zxy on 14-6-18.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ZXYRootViewController.h"
#import "ZXYRootView.h"
#import "ZXYDBManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZXYAboutViewController.h"
#import "ZXYContactViewController.h"
#import "LeeViewController.h"
#import "WSAddClothingTableViewController.h"
#import "ZXYAddPersonModelTableViewController.h"
#import "WSClosetDisplayViewController.h"
#import "LDQViewController.h"


#define Duration 0.2

@interface ZXYRootViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>
{
    NSInteger _buttonSelectedIndex;
    NSString *_str;
    NSInteger _flag; //  标记是从哪里进入的相机
    //  拖动用的属性
    BOOL contain;
    BOOL _isDressed;
    BOOL _isOut;
    CGPoint startPoint;
    CGPoint originPoint;
    NSInteger selectedNumber;
    NSInteger _index;
}
@property (nonatomic, retain) ZXYRootView *rootView;
@property (nonatomic, retain) NSDictionary *dict;
@property (nonatomic, retain) NSArray *listArray;
//@property (nonatomic, retain) NSMutableArray *selectedImageNameArray;
@property (nonatomic, retain) NSMutableArray *itemArray;
@property (nonatomic, retain) NSMutableDictionary *dressDict;

- (void)scrollViewLoadDataWithClassName:(NSString *)className;
- (void)scrollViewLoadDataWithSubClassName:(NSString *)subClassName;

@end

@implementation ZXYRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"试衣间";
        self.itemArray = [NSMutableArray array];
//        self.selectedImageNameArray = [NSMutableArray array];
        _isOut = NO;
        _isDressed = NO;
    }
    return self;
}

- (void)loadView
{
    self.rootView = [[[ZXYRootView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view = _rootView;
}

- (void)viewWillAppear:(BOOL)animated
{

    if ([ZXYDBManager sharedDataManager].isCreatNewClothing) {
        [ZXYDBManager sharedDataManager].isCreatNewClothing = NO;
        LDQViewController *ldqVC = [LDQViewController new];
        WSClothingModel *cloth = [[ZXYDBManager sharedDataManager] searchOneDataWithImageName:[ZXYDBManager sharedDataManager].clothingName];
        ldqVC.className = cloth.className;
        ldqVC.imagePath = cloth.imageName;
        [self.navigationController pushViewController:ldqVC animated:YES];

    }
    
    
    if ([[ZXYDBManager sharedDataManager] searchDataWithClassName:@"上衣"].count > 0) {
        [self scrollViewLoadDataWithClassName:@"上衣"];
    } else {
        [self removeAllSubViewsOfScrollView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_rootView.scrollView.frame) / 2, CGRectGetWidth(_rootView.scrollView.frame), KImageHeight)];
        label.text = @"您暂时还没有此类型衣服，点击右上角添加吧~~";
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.tintColor = [UIColor grayColor];
        [_rootView.scrollView addSubview:label];
        [label release];
        _rootView.numberLabel.text = @"上衣 (0)";
    }
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLoad"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[ZXYDBManager sharedDataManager] openDB];

    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    UIBarButtonItem *listBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-bar-icon-menu"] style:UIBarButtonItemStyleBordered target:self action:@selector(listBarButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = listBarButtonItem;
    
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"capture-camera.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(addBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
    
    //  给分类按钮添加事件
    [_rootView.coatButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView.pantsButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView.skirtButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView.shoesButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView.bagButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView.accessoryButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView.allButton addTarget:self action:@selector(allButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置图片轻拍
    UITapGestureRecognizer *coatTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clean:)];
    [_rootView.coatView addGestureRecognizer:coatTapGR];
    UITapGestureRecognizer *coat2TapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clean:)];
    [_rootView.coat2View addGestureRecognizer:coat2TapGR];
    UITapGestureRecognizer *pantsTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clean:)];
    [_rootView.pantsView addGestureRecognizer:pantsTapGR];
    UITapGestureRecognizer *skirtTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clean:)];
    [_rootView.skirtView addGestureRecognizer:skirtTapGR];
    UITapGestureRecognizer *shoesTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clean:)];
    [_rootView.shoesView addGestureRecognizer:shoesTapGR];
    UITapGestureRecognizer *bagTaGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clean:)];
    [_rootView.bagView addGestureRecognizer:bagTaGR];

    
    //  给tableView设置代理
    self.rootView.subClassTableView.dataSource = self;
    self.rootView.subClassTableView.delegate = self;
    self.rootView.listTableView.dataSource = self;
    self.rootView.listTableView.delegate = self;
    
    //  初始化字典和数组
    self.dict = @{@"100": @"上衣", @"101": @"裤子", @"102": @"裙子", @"103": @"鞋", @"104": @"包", @"105": @"饰品"};
    self.listArray = @[@"推荐搭配", @"关于衣柜", @"联系我们"];
    self.dressDict = [NSMutableDictionary dictionary];
    
    _buttonSelectedIndex = 100;
    
    //  首次进入显示上衣组
//    [self scrollViewLoadDataWithClassName:@"上衣"];
   
    
    //  给镜子添加事件
    [_rootView.mirrorButton addTarget:self action:@selector(mirrorButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  添加手势
//    [self.rootView.panGR addTarget:self action:@selector(drawerAction:)];
    [self.rootView.tapGR addTarget:self action:@selector(hide)];
}

#pragma mark 轻拍隐藏所有弹出视图
- (void)hide
{
    [self hide:_rootView.listTableView];
    [self hide:_rootView.subClassTableView];
}

#pragma mark 镜子监听事件
- (void)mirrorButtonAction:(UIButton *)sender
{
    if (_dressDict.count == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有选择衣物到试衣间哦~赶紧搭配试试吧" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的~", nil];
        alertView.tag = 502;
        [alertView show];
    } else {
        NSMutableSet *set = [[ZXYDBManager sharedDataManager] searchPersonModelWithDress:_dressDict];
        if (set.count == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有这身衣服的记忆哦~~马上记录吧" delegate:self cancelButtonTitle:@"不用了" otherButtonTitles:@"好的", nil];
            alertView.tag = 500;
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的衣柜里有这身衣服的记忆哦~~" delegate:self cancelButtonTitle:nil otherButtonTitles:@"回顾旧的", @"添加新的", nil];
            alertView.tag = 501;
            [alertView show];
        }
    }
}

#pragma mark AlertView监听事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d", buttonIndex);
    if (alertView.tag == 500) {
        switch (buttonIndex) {
            case 1:
                _flag = 2;
                [self actionSheet];
                break;
            default:
                break;
        }
    }
    if (alertView.tag == 501) {
        switch (buttonIndex) {
            case 0:
            {
                //跳转到有这身衣服的界面
                break;
            }
            case 1:
                _flag = 2;
                [self actionSheet];
                break;
            default:
                break;
        }
    }
}

#pragma mark allButton监听事件
- (void)allButtonAction:(UIButton *)sender
{
    WSClosetDisplayViewController *wsClosetVC = [WSClosetDisplayViewController new];
    [self.navigationController pushViewController:wsClosetVC animated:YES];
}


#pragma mark 隐藏导航栏上方系统时间、电池显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark 手势滑出左侧菜单栏
- (void)drawerAction:(UIPanGestureRecognizer *)sender
{
    CGPoint point = [sender translationInView:_rootView];
    if (point.x > 0) {
        [self show:_rootView.listTableView];
    } else if (point.x < 0){
        [self hide:_rootView.listTableView];
    }
}
#pragma mark 点击弹出左侧菜单栏
- (void)listBarButtonItemAction:(UIBarButtonItem *)sender
{
    if (_rootView.listTableView.alpha == 0) {
        [_rootView bringSubviewToFront:_rootView.listTableView];
        [self show:_rootView.listTableView];
    } else {
        [self hide:_rootView.listTableView];
    }
}
#pragma mark 弹出视图
- (void)show:(UIView *)sender
{
    CATransition *transition = [CATransition animation];
    transition.duration = .3;
    sender.alpha = 1;
    _rootView.scrollView.alpha = 0.5;
    _rootView.dressView.alpha = 0.5;
    if (sender == _rootView.subClassTableView) {
        transition.subtype = @"fromRight";
    } else {
        [self hide:_rootView.subClassTableView];
    }
    transition.type = @"moveIn";
    [sender.layer addAnimation:transition forKey:@"transition"];
}
#pragma mark 隐藏视图
- (void)hide:(UIView *)sender
{
    CATransition *transition = [CATransition animation];
    transition.duration = .3;
    sender.alpha = 0;
    _rootView.scrollView.alpha = 1;
    _rootView.dressView.alpha = 1;
    transition.type = @"reveal";
    if (sender == _rootView.listTableView) {
        transition.subtype = @"fromRight";
    }
    [sender.layer addAnimation:transition forKey:@"transition"];
}
#pragma mark 添加衣物
- (void)addBarButtonItemAction:(UIBarButtonItem *)sender
{
    _flag = 1;
    [self actionSheet];
}
#pragma mark 弹出actionSheet
- (void)actionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择添加衣物到衣柜的方式"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    [actionSheet showInView:self.view];
}
#pragma mark actionSheet监听事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [self useCamera];
            break;
        }
        case 1:
        {
            [self useAlbum];
        }
        default:
            break;
    }
}
#pragma mark 调用相机
- (void)useCamera
{
    //判断是否可以打开相机，模拟器此功能无法使用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;  //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:Nil];
        [picker release];
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误提示" message:@"您没有摄像头" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
    }
}
#pragma mark 调用相册
- (void)useAlbum
{
    //相册是可以用模拟器打开的
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;//是否可以编辑
        
        //打开相册选择照片
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        [picker release];
    }
}
#pragma mark - 相机代理事件
#pragma mark 得到相片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //得到图片
    UIImage *orignimage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *image = [self OriginImage:orignimage scaleToSize:CGSizeMake(200, 200 * orignimage.size.height / orignimage.size.width)];

    
    //得到系统当前时间
    NSDate *nowDate = [NSDate date];//  格林威治时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8 * 3600]]; //  东八区 得到本地时间
    NSString *dateStr = [formatter stringFromDate:nowDate];
    [formatter release];
    
    //将图片转成NSData类型存入沙河 以时间命名
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *imagePath = [KDocument stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", dateStr]];
    [imageData writeToFile:imagePath atomically:YES];
    
/*
//    //  获取到图片名字
//    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
//    // define the block to call when we get the asset based on the url (below)
//    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
//    {
//        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
//        NSLog(@"[imageRep filename] : %@", [imageRep filename]);
//    };
//    // get the asset library and fetch the asset based on the ref url (pass in block above)
//    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
//    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
 */
    //图片存入相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    [self dismissViewControllerAnimated:YES completion:^{
        switch (_flag) {
            case 1:
            {
                WSAddClothingTableViewController *addVC = [[WSAddClothingTableViewController alloc] init];
                addVC.getImagePath = imagePath;
                UINavigationController *addNC = [[UINavigationController alloc] initWithRootViewController:addVC];
                [self presentViewController:addNC animated:YES completion:nil];
                [addVC release];
                break;
            }
            case 2:
            {
                //  跳转到添加新的PersonModel界面
                ZXYAddPersonModelTableViewController *addVC = [[ZXYAddPersonModelTableViewController alloc] initWithStyle:UITableViewStylePlain];
                addVC.getImageName = imagePath;
                addVC.dict = _dressDict;
                [self.navigationController pushViewController:addVC animated:YES];
                [addVC release];
                break;
            }
            default:
                break;
        }
    }];
}
#pragma mark 取消选择
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 分类按钮监听事件
- (void)buttonAction:(UIButton *)sender
{
    for (int i = 100; i < 106; i ++) {
        if (sender.tag == i) {
            [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"category-icon-%d.png", i]] forState:UIControlStateNormal];
        }else {
            [((UIButton *)[_rootView viewWithTag:i]) setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"category-icon-style2-%d.png", i]] forState:UIControlStateNormal];
        }
    }
    _buttonSelectedIndex = sender.tag;
    [_rootView.subClassTableView reloadData];
    _rootView.subClassTableView.contentOffset = CGPointMake(0, 0);
    for (UIButton *button in _rootView.scrollView.subviews) {
        [_itemArray addObject:button];
    }
    
    
//    [_selectedImageNameArray removeAllObjects];
    [self scrollViewLoadDataWithClassName:_dict[[NSString stringWithFormat:@"%d", sender.tag]]];
    [self show:_rootView.subClassTableView];
}
#pragma mark 移除scrollView上的所有子视图
- (void)removeAllSubViewsOfScrollView
{
    NSArray *array = _rootView.scrollView.subviews;
    for (UIView *view in array) {
        [view removeFromSuperview];
    }
}

#pragma mark - UITableView代理事件
#pragma mark 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 300) {
        return 3;
    }
    return [[[ZXYDBManager sharedDataManager] searchWithClassName:_dict[[NSString stringWithFormat:@"%d", _buttonSelectedIndex]]] count];
}
#pragma mark tableView内容显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_identify = @"cell_identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identify];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identify] autorelease];
    }
    if (tableView.tag == 301) {
        NSMutableArray *array = [[ZXYDBManager sharedDataManager] searchWithClassName:_dict[[NSString stringWithFormat:@"%d", _buttonSelectedIndex]]];
        cell.textLabel.text = array[indexPath.row];
        cell.textLabel.numberOfLines = 0;
//        cell.textLabel.font = [UIFont systemFontOfSize:11.f];
        cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-background.png"]] autorelease];
        cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu-button-pressed-background.png"]] autorelease];
    }
    if (tableView.tag == 300) {
        cell.textLabel.text = _listArray[indexPath.row];
        cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-background.png"]] autorelease];
        cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu-button-pressed-background.png"]] autorelease];
    }
    return cell;
}
#pragma mark 计算cell的高度
- (CGFloat)calculateHeight:(NSString *)str
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(CGRectGetWidth(_rootView.subClassTableView.frame), 300) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.f]} context:nil];
//    NSLog(@"%f", rect.size.height);
    return rect.size.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 301) {
        NSMutableArray *array = [[ZXYDBManager sharedDataManager] searchWithClassName:_dict[[NSString stringWithFormat:@"%d", _buttonSelectedIndex]]];
        _str = array[indexPath.row];
//        NSLog(@"%@", _str);
        
        CGFloat height = [self calculateHeight:_str];
        return height + KHeight;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 301) {
        UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        NSArray *array = _rootView.scrollView.subviews;
        for (UIView *view in array) {
            [view removeFromSuperview];
        }
//        [_itemArray removeAllObjects];
//        [_selectedImageNameArray removeAllObjects];
        [self scrollViewLoadDataWithSubClassName:cell.textLabel.text];
        [self hide:_rootView.subClassTableView];
    }
    if (tableView.tag == 300) {
        switch (indexPath.row) {
            case 0:
            {
                LeeViewController *leeVC = [[LeeViewController alloc] init];
                [self.navigationController pushViewController:leeVC animated:YES];
                [self hide:_rootView.listTableView];
                [leeVC release];
                break;
            }
            case 1:
            {
                ZXYAboutViewController *aboutVC = [[ZXYAboutViewController alloc] init];
                [self.navigationController pushViewController:aboutVC animated:YES];
                [self hide:_rootView.listTableView];
                [aboutVC release];
                break;
            }
            case 2:
            {
                ZXYContactViewController *contactVC = [[ZXYContactViewController alloc] init];
                [self.navigationController pushViewController:contactVC animated:YES];
                [self hide:_rootView.listTableView];
                [contactVC release];
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark 图片展示实现
- (void)scrollViewLoadDataWithClassName:(NSString *)className
{
    NSMutableArray *array = [[ZXYDBManager sharedDataManager] searchDataWithClassName:className];
    [self loadData:array];
    _rootView.numberLabel.text = [NSString stringWithFormat:@"%@ (%d)", className, array.count];
}
- (void)scrollViewLoadDataWithSubClassName:(NSString *)subClassName
{
    NSMutableArray *array = [[ZXYDBManager sharedDataManager] searchDataWithSubClassName:subClassName];
    [self loadData:array];

    _rootView.numberLabel.text = [NSString stringWithFormat:@"%@ (%d)", subClassName, array.count];
}
- (void)scrollViewLoadAllData
{
    NSMutableArray *array = [[ZXYDBManager sharedDataManager] searchData];
    [self loadData:array];
    _rootView.numberLabel.text = [NSString stringWithFormat:@"全部衣物 (%d)", array.count];
}
#pragma mark scrollViewLoadData
- (void)loadData:(NSMutableArray *)array
{
    [self removeAllSubViewsOfScrollView];
    [_itemArray removeAllObjects];
    for (int i = 0; i < array.count; i ++) {
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageButton.frame = CGRectMake(KMargin + (KImageWidth + KMargin) * (i % 3), KMargin + (KImageHeight + KMargin) * (i / 3), KImageWidth, KImageHeight);
        imageButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        UIImage *image = [UIImage imageWithContentsOfFile:array[i]];
        [imageButton setImage:image forState:UIControlStateNormal];
        imageButton.tag = i;
        imageButton.backgroundColor = [UIColor whiteColor];
        imageButton.titleLabel.text = array[i];
        imageButton.titleLabel.hidden = YES;
        
        imageButton.layer.cornerRadius = 3;
        imageButton.layer.borderColor = K_MAINCOLOR.CGColor;
        imageButton.layer.borderWidth = 1;
        imageButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        //  添加点击事件
        [imageButton addTarget:self
                        action:@selector(imageSelectedAction:)
              forControlEvents:UIControlEventTouchUpInside];
        
        //  添加拖动属性
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
        [imageButton addGestureRecognizer:longGesture];
        [self.itemArray addObject:imageButton];
        
        [_rootView.scrollView addSubview:imageButton];
    }
    _rootView.scrollView.contentSize = CGSizeMake(CGRectGetWidth(_rootView.scrollView.frame), (KMargin + KImageHeight) * ((array.count + 2) / 3));
    
    if (array.count == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_rootView.scrollView.frame) / 2, CGRectGetWidth(_rootView.scrollView.frame), KImageHeight)];
        label.text = @"您暂时还没有此类型衣服，点击右上角添加吧~~";
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.tintColor = [UIColor grayColor];
        [_rootView.scrollView addSubview:label];
        [label release];
    }
    
}

#pragma mark -图片拖动
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender
{
    
    UIButton *btn = (UIButton *)sender.view;
    selectedNumber = btn.tag;
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        startPoint = [sender locationInView:sender.view];
        originPoint = btn.center;
        
        [UIView animateWithDuration:Duration animations:^{
            
            btn.transform = CGAffineTransformMakeScale(1.1, 1.1);
            btn.alpha = 0.7;
        }];
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        
        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x-startPoint.x;
        CGFloat deltaY = newPoint.y-startPoint.y;
        btn.center = CGPointMake(btn.center.x+deltaX,btn.center.y+deltaY);
        
        
        CGPoint centerPoint = [_rootView.scrollView convertPoint:btn.center fromView:self.view];
        _index = [self indexOfPoint:centerPoint withButton:btn];
        
        if (_index < 0)
        {
            contain = NO;
        }
        else
        {
            if (selectedNumber > _index) {
                NSLog(@"往前");
                CGPoint tem = originPoint;
                originPoint = [_itemArray[_index] center];
                [UIView animateWithDuration:Duration animations:^{
                    for (NSInteger i = _index; i < selectedNumber - 1; i ++) {
                        //                        CGPoint temp = CGPointZero;
                        UIButton *button = _itemArray[i];
                        button.center = [_itemArray[i + 1] center];
                        button.tag = button.tag + 1;
                    }
                    UIButton *button = _itemArray[selectedNumber - 1];
                    button.center = tem;
                    button.tag = button.tag + 1;
                    btn.tag = _index;
                    [_itemArray removeObject:btn];
                    [_itemArray insertObject:btn atIndex:_index];
                }];
                
            }else if(selectedNumber < _index){
                
                NSLog(@"往后");
                CGPoint tem = originPoint;
                originPoint = [_itemArray[_index] center];
                [UIView animateWithDuration:Duration animations:^{
                    for (NSInteger i = _index; i > selectedNumber + 1; i --) {
                        //                        CGPoint temp = CGPointZero;
                        UIButton *button = _itemArray[i];
                        NSLog(@"%d", i);
                        button.center = [_itemArray[i - 1] center];
                        button.tag = button.tag - 1;
                    }
                    UIButton *button = _itemArray[selectedNumber + 1];
                    button.center = tem;
                    button.tag = button.tag - 1;
                    btn.tag = _index;
                    [_itemArray removeObject:btn];
                    [_itemArray insertObject:btn atIndex:_index];
                }];
                
            }
            contain = YES;
        }
        [self.view addSubview:btn];
    }    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        if (CGRectContainsPoint(_rootView.personView.frame, btn.center)) {
            NSLog(@"%@", btn.titleLabel.text);
            WSClothingModel *clothing = [[ZXYDBManager sharedDataManager] searchOneDataWithImageName:btn.titleLabel.text];
            NSLog(@"%@", clothing.className);
    
            if ([clothing.className isEqualToString:@"上衣"]) {
                if (_rootView.coatView.image == nil) {
                    if (![_rootView.coatView.image isEqual:[UIImage imageWithContentsOfFile:clothing.imageName]] && ![_rootView.coat2View.image isEqual:[UIImage imageWithContentsOfFile:clothing.imageName]]) {
                        _rootView.coatView.image = [UIImage imageWithContentsOfFile:clothing.imageName];
                        [_dressDict setValue:btn.titleLabel.text forKey:@"coatName"];
                    }
                }else {
                    if (![_rootView.coatView.image isEqual:[UIImage imageWithContentsOfFile:clothing.imageName]] && ![_rootView.coat2View.image isEqual:[UIImage imageNamed:clothing.imageName]]) {
                        _rootView.coat2View.image = _rootView.coatView.image;
                        _rootView.coatView.image = [UIImage imageWithContentsOfFile:clothing.imageName];
                        [_dressDict setValue:btn.titleLabel.text forKey:@"coatName2"];
                    }
                }
                
            }else if ([clothing.className isEqualToString:@"裤子"]) {
                _rootView.pantsView.image = [UIImage imageWithContentsOfFile:clothing.imageName];
                [_dressDict setValue:btn.titleLabel.text forKey:@"pantsName"];
            }else if ([clothing.className isEqualToString:@"鞋"]) {
                _rootView.shoesView.image = [UIImage imageWithContentsOfFile:clothing.imageName];
                [_dressDict setValue:btn.titleLabel.text forKey:@"shoesName"];
            }else if ([clothing.className isEqualToString:@"包"]) {
                _rootView.bagView.image = [UIImage imageWithContentsOfFile:clothing.imageName];
                [_dressDict setValue:btn.titleLabel.text forKey:@"bagName"];
            }else if ([clothing.className isEqualToString:@"裙子"]) {
                _rootView.skirtView.image = [UIImage imageWithContentsOfFile:clothing.imageName];
                [_dressDict setValue:btn.titleLabel.text forKey:@"skirtName"];
            }
            
            if (_itemArray.count > 1 && ![btn isEqual:_itemArray[0]]) {
                NSLog(@"往前");
                CGPoint tem = originPoint;
                

                originPoint = [_itemArray[0] center];
                NSLog(@"%d", selectedNumber);
                [UIView animateWithDuration:Duration animations:^{
                    for (NSInteger i = 0; i < selectedNumber - 1; i ++) {
                        NSLog(@"i = %d", i);
                        UIButton *button = _itemArray[i];
                        button.center = [_itemArray[i + 1] center];
                        button.tag = button.tag + 1;
                    }
                    UIButton *button = _itemArray[selectedNumber - 1];
                    button.center = tem;
                    button.tag = button.tag + 1;
                    btn.tag = 0;
                    NSLog(@"index = %d", [_itemArray indexOfObject:btn]);
                    [_itemArray removeObject:btn];
                    [_itemArray insertObject:btn atIndex:0];
                }];
            }
        }
        btn.center = [_rootView.scrollView convertPoint:btn.center fromView:self.view];
        [_rootView.scrollView addSubview:btn];
        [UIView animateWithDuration:Duration animations:^{
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0;
//            if (!contain) {
            
                btn.center = originPoint;

//            }
            
            
        }];
    }
}

- (NSInteger)indexOfPoint:(CGPoint)point withButton:(UIButton *)btn
{
    for (NSInteger i = 0;i<_itemArray.count;i++)
    {
        UIButton *button = _itemArray[i];
        if (button != btn)
        {
            if (CGRectContainsPoint(button.frame, point))
            {
                return i;
            }
        }
    }
    return -1;
}
#pragma mark 衣服换下
- (void)clean:(UITapGestureRecognizer *)sender
{
    UIImageView *imageView = (UIImageView *)sender.view;
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = .8;
    transition.type = @"rippleEffect";
    [imageView.layer addAnimation:transition forKey:@"transition"];
    imageView.image = nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 改变图片大小
- (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

#pragma mark 点击图片的效果
- (void)imageSelectedAction:(UIButton *)sender
{
    LDQViewController *ldqVC = [LDQViewController new];
    NSLog(@"%@", sender.titleLabel.text);
    WSClothingModel *cloth = [[ZXYDBManager sharedDataManager] searchOneDataWithImageName:sender.titleLabel.text];
    ldqVC.className = cloth.className;
    ldqVC.imagePath = cloth.imageName;
    [self.navigationController pushViewController:ldqVC animated:YES];
    
}





@end
