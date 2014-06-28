//
//  ZXYAddPersonModelTableViewController.m
//  ClosetMemory
//
//  Created by zxy on 14-6-24.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ZXYAddPersonModelTableViewController.h"
#import "UILabel+myLabel.h"
#import "UIButton+myButton.h"
#import "ZXYDBManager.h"
#import "LDQPerosnDetailsViewController.h"

@interface ZXYAddPersonModelTableViewController () <UITextFieldDelegate>

@property (nonatomic, retain) UIView *datePickerView;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic,retain) UITextField *dataField;
@property (nonatomic, retain) UITextField *remarkTextField;
@property (nonatomic, retain) UITextField *moodTextField;

@end

@implementation ZXYAddPersonModelTableViewController

- (void)dealloc
{
    [_datePicker release];
    [_datePickerView release];
    [_dataField release];
    [_remarkTextField release];
    [_moodTextField release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"添加镜子记忆";
        self.datePicker = [[[UIDatePicker alloc] init] autorelease];
        _datePicker.date = [NSDate date];
        self.dict = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(makeAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)makeAction:(UIBarButtonItem *)sender
{
    NSString *coatName = @"";
    NSString *coatName2 = @"";
    NSString *pantsName = @"";
    NSString *skirtName = @"";
    NSString *shoesName = @"";
    NSString *bagName = @"";
    NSMutableArray *clothArray = [NSMutableArray arrayWithCapacity:1];

    for (NSString *key in self.dict.allKeys) {
        if ([key isEqualToString:@"coatName"]) {
            coatName = _dict[key];
            [clothArray addObject:coatName];
        }
        if ([key isEqualToString:@"coatName2"]) {
            coatName2 = _dict[key];
            [clothArray addObject:coatName2];
        }
        if ([key isEqualToString:@"pantsName"]) {
            pantsName = _dict[key];
            [clothArray addObject:pantsName];
        }
        if ([key isEqualToString:@"skirtName"]) {
            skirtName = _dict[key];
            [clothArray addObject:skirtName];
        }
        if ([key isEqualToString:@"shoesName"]) {
            shoesName = _dict[key];
            [clothArray addObject:shoesName];
        }
        if ([key isEqualToString:@"bagName"]) {
            bagName = _dict[key];
            [clothArray addObject:bagName];
        }
    }
    [[ZXYDBManager sharedDataManager] insertPersonModelWithPersonImageName:self.getImageName withCoatName:coatName withCoatName2:coatName2 withPantsName:pantsName withSkirtName:skirtName withShoesName:shoesName withBagName:bagName withDate:_datePicker.date withRemarks:_remarkTextField.text withMood:_moodTextField.text];
    
    // 跳转界面
    LDQPerosnDetailsViewController *detailVC = [LDQPerosnDetailsViewController new];
    detailVC.clothDict = self.dict;
    detailVC.imagePath = self.getImageName;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark cell头view的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            break;
            
        default:
            return 30;
            break;
    }
    return 20;
}

#pragma mark 头view的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor = K_MAINCOLOR;
    if (section == 1) {
        UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menu-button-agenda@2x"]];
        imageview.frame = CGRectMake(5, 6, 20, 20);
        [view addSubview:imageview];
        [imageview release];
        UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 60, 30)]autorelease];
        label.text = @"日期:";
        [view addSubview:label];
    } else if (section == 2){
        UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"item-info-icon-remarks@2x"]];
        imageview.frame = CGRectMake(5, 6, 20, 20);
        [view addSubview:imageview];
        [imageview release];
        UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 60, 30)]autorelease];
        label.text = @"备注:";
        [view addSubview:label];
    } else if (section == 3) {
        UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menu-button-favorites@2x"]];
        imageview.frame = CGRectMake(5, 6, 20, 20);
        [view addSubview:imageview];
        [imageview release];
        UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 60, 30)]autorelease];
        label.text = @"心情:";
        [view addSubview:label];
    }
//    [view release];
    return view;
    
}

#pragma mark 每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 280;
            break;
            
        default:
            return 44;
            break;
    }
}

#pragma mark 清除背景
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

#pragma mark cell显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先声明一个cell的标记
    static NSString *cell_id = @"cell_id";
    //创建UITableViewCell 并清空
    UITableViewCell *cell = nil;
    //去重用队列中查找是否有可用的cell
    cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    // 没有找到可用的Cell就需要自己创建
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id] autorelease];
    }
    if (indexPath.section == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:self.getImageName]];
        imageView.frame = CGRectMake(KWidth, 0, 250, cell.frame.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.backgroundView = imageView;
        [imageView release];
        //        [cell addSubview:_imageView];
    } else if (indexPath.section == 1){
            UIButton *dataButton = [UIButton buttonWithFrame:CGRectMake(0, 0, 320, 40) Title:@"选择日期" color:[UIColor whiteColor] image:nil];
            [dataButton addTarget:self action:@selector(dataButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:dataButton];
            
        self.dataField = [[[UITextField alloc]initWithFrame:CGRectMake(10, 5, 300, 30)] autorelease];
        _dataField.borderStyle = UITextBorderStyleRoundedRect;
        _dataField.returnKeyType = UIKeyboardAppearanceDefault;
        _dataField.tag = 13;
        _dataField.delegate = self;
        _dataField.placeholder = @"年-月-日";
        _dataField.textAlignment = NSTextAlignmentCenter;
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy年    MM月    dd日"];
        _dataField.text = [dateFormatter stringFromDate:[NSDate date]];
        [dateFormatter release];
        _dataField.enabled = NO;
        [cell addSubview:self.dataField];
    } else if (indexPath.section == 2) {
        self.remarkTextField = [[[UITextField alloc]initWithFrame:CGRectMake(10, 5, 300, 30)] autorelease];
        _remarkTextField.borderStyle = UITextBorderStyleRoundedRect;
        _remarkTextField.returnKeyType = UIKeyboardAppearanceDefault;
        _remarkTextField.tag = 14;
        _remarkTextField.delegate = self;
        [cell addSubview:self.remarkTextField];
        
    } else if (indexPath.section == 3) {
        self.moodTextField = [[[UITextField alloc]initWithFrame:CGRectMake(10, 5, 300, 30)] autorelease];
        _moodTextField.borderStyle = UITextBorderStyleRoundedRect;
        _moodTextField.returnKeyType = UIKeyboardAppearanceDefault;
        _moodTextField.tag = 14;
        _moodTextField.delegate = self;
        [cell addSubview:self.moodTextField];
    }
    return cell;
}

#pragma mark 日期点击事件
- (void)dataButtonAction:(UIButton *)sender
{
    self.datePickerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 500, 320, 200)] autorelease];
    _datePickerView.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(250, 0, 50, 30);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(doneAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [_datePickerView addSubview:button];
    
    self.datePicker = [[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 20, 0, 0)] autorelease];
    _datePicker.alpha = 1.0;
    _datePicker.tag = 100;
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.maximumDate = [NSDate date];
    _datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-24 * 3600 * 365 * 10];
    [_datePickerView addSubview:_datePicker];
    [self.view addSubview:_datePickerView];
    [_datePicker release];
    [UIView animateWithDuration:0.5 animations:^{
        [_datePickerView setFrame:CGRectMake(0, 200, 320, 256)];
    }];
    
}

#pragma mark 日历选择完成
- (void)doneAction:(UIButton *)button
{
    [UIView animateWithDuration:0.5 animations:^{
        [_datePickerView setFrame:CGRectMake(0, 500, 320, 276)];
        
    } completion:^(BOOL finished) {
        if (finished) {
            [_datePickerView removeFromSuperview];
        }
    }];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    
    _dataField.text = [dateFormatter stringFromDate:_datePicker.date];
    [dateFormatter release];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
