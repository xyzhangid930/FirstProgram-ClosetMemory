//
//  LDQViewController.m
//  CloseMemory2
//
//  Created by lanou3g on 14-6-25.
//  Copyright (c) 2014年 吕东强. All rights reserved.
//

#import "LDQViewController.h"
#import "UILabel+myLabel.h"
#import <QuartzCore/QuartzCore.h>
#import "UIButton+myButton.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"
#import "WSClothingModel.h"
#import "ZXYDBManager.h"

@interface LDQViewController () <UIActionSheetDelegate>
{
    NSInteger _index;
}
@property (nonatomic,retain) UILabel *waistLabel;//接受label
@property (nonatomic, retain) NSMutableArray *clothArray;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic,retain) UILabel *pinpaiLabel;//品牌
@property (nonatomic,retain) UILabel *priceLabel;//价格
@property (nonatomic,retain) UILabel *colorLabel;//颜色
@property (nonatomic,retain) UILabel *dayLabel;//日期
@property (nonatomic,retain) UILabel *childLabel;//子分类
@property (nonatomic,retain) UILabel *jijieLabel;//季节
@property (nonatomic, retain) UIPanGestureRecognizer *panGR;


@end

@implementation LDQViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.clothArray = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addAllViews];
    self.panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGRAction:)];
    [self.view addGestureRecognizer:_panGR];

    self.clothArray = [[ZXYDBManager sharedDataManager] searchDataWithClassName:self.className];
    _index = [_clothArray indexOfObject:self.imagePath];
   
    [self loadData];

}
- (void)addAllViews
{
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KImageWidth - 20, 1.5 * KHeight, K_MAINSCREEN_WIDTH - 100, K_MAINSCREEN_HEIGHT - 300)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;//设置图片自适应
    [self.view addSubview:_imageView];
    
    UILabel *mainLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, K_MAINSCREEN_HEIGHT - 280, 320, 40)]autorelease];
    mainLabel.text = @"基本信息:";
    mainLabel.backgroundColor = K_TEXTCOLOR;
    [self.view addSubview:mainLabel];
    
    UIView *showView = [[[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMinY(mainLabel.frame) + 30,K_MAINSCREEN_WIDTH,K_MAINSCREEN_HEIGHT - 300)]autorelease];
    showView.backgroundColor =K_MAINCOLOR;
    [self.view addSubview:showView];
    
    self.waistLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMinX(showView.frame) ,CGRectGetMinX(showView.frame) + 10, 60, 20) Text:@"品牌:" TextAlignment:(NSString *)NSTextAlignmentCenter];
    [showView addSubview:_waistLabel];
    self.pinpaiLabel = [UILabel labelWithFrame:CGRectMake(60, CGRectGetMinY(_waistLabel.frame), 60, 20) Text:@"" TextAlignment:(NSString *)NSTextAlignmentCenter];
    [showView addSubview:_pinpaiLabel];
    self.waistLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMinX(_waistLabel.frame) , CGRectGetMinY(_pinpaiLabel.frame) + 30, 60, 20) Text:@"价格:" TextAlignment:(NSString *)NSTextAlignmentCenter];
    [showView addSubview:_waistLabel];
    
    self.priceLabel = [UILabel labelWithFrame:CGRectMake(60, CGRectGetMinY(_pinpaiLabel.frame) + 30, 60, 20) Text:@"" TextAlignment:(NSString *)NSTextAlignmentCenter];

    [showView addSubview:_priceLabel];
    self.waistLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMinX(_waistLabel.frame), CGRectGetMinY(_priceLabel.frame) + 30, 60, 20) Text:@"季节:" TextAlignment:(NSString *)NSTextAlignmentCenter];
    [showView addSubview:_waistLabel];
    self.jijieLabel = [UILabel labelWithFrame:CGRectMake(60, CGRectGetMinY(_priceLabel.frame) + 30, 60, 20) Text:@"" TextAlignment:(NSString *)NSTextAlignmentCenter];

    [showView addSubview:_jijieLabel];
    self.waistLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMinX(_waistLabel.frame), CGRectGetMinY(_jijieLabel.frame) + 30, 60, 20) Text:@"颜色:" TextAlignment:(NSString *)NSTextAlignmentCenter];
    [showView addSubview:_waistLabel];
    self.colorLabel = [UILabel labelWithFrame:CGRectMake(60, CGRectGetMinY(_jijieLabel.frame) + 30, 320, 20) Text:@"" TextAlignment:(NSString *)NSTextAlignmentLeft];

    [showView addSubview:_colorLabel];
    self.waistLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMinX(_waistLabel.frame), CGRectGetMinY(_colorLabel.frame) + 30, 60, 20) Text:@"日期:" TextAlignment:(NSString *)NSTextAlignmentCenter];
    [showView addSubview:_waistLabel];
    
    self.dayLabel = [UILabel labelWithFrame:CGRectMake(60, CGRectGetMinY(_colorLabel.frame) + 30, 160, 20) Text:@"" TextAlignment:(NSString *)NSTextAlignmentCenter];

    [showView addSubview:_dayLabel];
    
    self.waistLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMinX(_waistLabel.frame), CGRectGetMinY(_dayLabel.frame) + 30, 60, 20) Text:@"子分类:" TextAlignment:(NSString *)NSTextAlignmentCenter];
    [showView addSubview:_waistLabel];
    self.childLabel = [UILabel labelWithFrame:CGRectMake(60, CGRectGetMinY(_dayLabel.frame) + 30, 150, 20) Text:@"" TextAlignment:nil];
    _childLabel.numberOfLines = 0;
    [showView addSubview:_childLabel];
    
    //  分享
    UIButton *shareButton = [UIButton button1WithFrame:CGRectMake(2 *KWidth, K_MAINSCREEN_HEIGHT - 40,1.5 * KWidth, 2 * KWidth) Title:@"" color:nil image:nil];
    shareButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iconfont-fenxiang.png"]];
    [shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    
    //  删除
    UIButton *deleteButton= [UIButton button1WithFrame:CGRectMake(2.5 * KImageHeight, K_MAINSCREEN_HEIGHT - 40,1.5 * KWidth, 2 * KWidth) Title:@"" color:nil image:nil];
    [deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    deleteButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iconfont-shanchu-3.png"]];
    [self.view addSubview:deleteButton];

    
}

- (void)loadData
{
    WSClothingModel *cloth = [[ZXYDBManager sharedDataManager] searchOneDataWithImageName:_clothArray[_index]];
    _imageView.image = [UIImage imageWithContentsOfFile:cloth.imageName];
    self.imagePath = cloth.imageName;
    _pinpaiLabel.text = cloth.brand;
    _priceLabel.text = cloth.price;
    _jijieLabel.text = cloth.season;
    _colorLabel.text = cloth.color;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    _dayLabel.text = [dateFormatter stringFromDate:cloth.date];
    [dateFormatter release];
    _childLabel.text = cloth.subClassName;
    
    self.title = [self clothingNameWith:cloth];
    NSLog(@"%@", self.title);
    //    [cloth release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 平移方法
-(void)panGRAction:(UIPanGestureRecognizer *)sender
{
    CGPoint point = [sender translationInView:self.view];
    if (point.x < -1 && abs(point.y) < 80) {
        NSLog(@"左移");
        if (sender.state == UIGestureRecognizerStateEnded) {
            _index --;
            if (_index >= 0) {
                [self loadData];
                CATransition *transition = [CATransition animation];
                transition.duration = .3;
                transition.type = @"push";
                transition.subtype = @"fromRight";
                [self.view.layer addAnimation:transition forKey:@"transition"];
            }
            if (_index == -1) {
                _index ++;
            }
        }
    } else if (point.x > 1 && abs(point.y) < 80){
        NSLog(@"右移");
        if (sender.state == UIGestureRecognizerStateEnded) {
            _index ++;
            if (_index <= _clothArray.count - 1) {
                [self loadData];
                CATransition *transition = [CATransition animation];
                transition.duration = .3;
                transition.type = @"push";
                [self.view.layer addAnimation:transition forKey:@"transition"];
            }
            if (_index == _clothArray.count) {
                _index --;
            }
        }
    }}
#pragma mark shareButtonAction点击事件
- (void)shareButtonAction:(UIButton *)sender
{
    NSString *shareText = @"";             //分享内嵌文字
    UIImage *shareImage = _imageView.image;          //分享内嵌图片
    
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
        _clothArray = [[ZXYDBManager sharedDataManager] searchDataWithClassName:self.className];
        if (_clothArray.count) {
            if (_clothArray.count == _index) {
                _index --;
            }
            [self loadData];
        } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

#pragma mark 衣服命名
- (NSString *)clothingNameWith:(WSClothingModel *)clothing
{
    NSString *string = @"";
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
