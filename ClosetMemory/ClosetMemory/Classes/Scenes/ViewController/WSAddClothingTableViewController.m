//
//  WSAddClothingTableViewController.m
//  ClosetMemory
//
//  Created by wangshun on 14-6-18.
//  Copyright (c) 2014年 2014蓝鸥20班. All rights reserved.
//

#import "WSAddClothingTableViewController.h"
#import "UIButton+myButton.h"
#import "WSClothingModel.h"
#import "LDQPerosnDetailsViewController.h"
#import "ZXYDBManager.h"
#import "LDQViewController.h"

@interface WSAddClothingTableViewController () <UITextFieldDelegate, QCheckBoxDelegate>
{
    UIView *_view1;
    UIView *_view2;
    UIView *_view3;
    UIImageView *_imageView;
    NSInteger _buttonSelectedIndex;
    NSString *_className;
    NSMutableString *_price;
}

@property (nonatomic, retain) NSDictionary *dict;
@property (nonatomic, retain) NSMutableArray *seasonArray;
@property (nonatomic, copy) NSString *colorprintInfo;//接受颜色
@property (nonatomic, copy) NSString *childPrintfInfo;//接受子分类
@property (nonatomic, retain) NSMutableArray *colorArray;//接受颜色的数组
@property (nonatomic, retain) NSMutableArray *flagArray;



@end

@implementation WSAddClothingTableViewController

- (void)dealloc
{
    [_textField release];
    [_mArray release];
    [_priceTextField release];
    [_childTextField release];
    [_remarkTextField release];

    [_dict release];
    [_seasonArray release];
    [_colorArray release];
    [_childPrintfInfo release];
    [_getImagePath release];
    [_datePicker release];
    [_datePickerView release];
    [_colorprintInfo release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.datePicker = [[[UIDatePicker alloc] init] autorelease];
        _datePicker.date = [NSDate date];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"添加服饰";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancelAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(makeAction:)];
    self.tableView.allowsSelection = NO;
    
    self.textField.delegate = self;
    self.priceTextField.delegate = self;
    
    self.mArray = [NSMutableArray arrayWithArray:[[ZXYDBManager sharedDataManager] searchWithClassName:@"上衣"]];
    NSLog(@"%@", _mArray);
    self.seasonArray = [NSMutableArray array];
    self.colorArray = [NSMutableArray array];
    
    self.dict = @{@"100": @"上衣", @"101": @"裤子", @"102": @"裙子", @"103": @"鞋", @"104": @"包", @"105": @"饰品"};
    _className = @"上衣";

    _buttonSelectedIndex = 100;
    self.flagArray = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {
        NSString *str = @"0";
        [_flagArray addObject:str];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
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

#pragma mark 每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 140;
            break;
        case 1:
            return 70;
            break;
        default:
            return 40;
            break;
    }
}

#pragma mark 每个cell的内容
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
    //正常使用
    if (indexPath.section == 0) {
        _view1 = [[[UIView alloc] initWithFrame:CGRectMake(100, 15, 210, 30)] autorelease];
        _view1.layer.borderWidth = 1.f;
        _view1.layer.borderColor = K_MAINCOLOR.CGColor;
        [cell addSubview:_view1];
        
        for (int i = 0 ; i < 6; i ++) {
            UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            imageButton.frame = CGRectMake(35 * i + 110, 20, 20, 20);
            imageButton.tag = 100 + i;
            imageButton.titleLabel.text = _dict[[NSString stringWithFormat:@"%d", imageButton.tag]];
            if (_buttonSelectedIndex == imageButton.tag) {
                [imageButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"category-icon-%d", i + 100]] forState:UIControlStateNormal];
            } else {
                [imageButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"category-icon-style2-%d", i + 100]] forState:UIControlStateNormal];
            }
            [imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:imageButton];
        }
        
        _view2 = [[UIView alloc] initWithFrame:CGRectMake(100, 55, 210, 30)];
        _view2.layer.borderWidth = 1.f;
        _view2.layer.borderColor = K_MAINCOLOR.CGColor;
        [cell addSubview:_view2];
        
        NSArray *seasonArray1 = @[@"春",@"夏",@"秋",@"冬"];
        int j = 0;
        for (int i = 0; i < 4; i ++) {
            UIButton *seasonButton = [UIButton buttonWithFrame:CGRectMake(50 * i + 120, 60, 20, 20) Title:[seasonArray1 objectAtIndex:j ++] color:nil image:nil];
            [seasonButton setTitleColor:K_TITLECOLOR forState:UIControlStateNormal];
            [seasonButton addTarget:self action:@selector(seasonButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:seasonButton];
        }
        
        //  颜色
        _view3 = [[UIView alloc] initWithFrame:CGRectMake(100, 98, 210, 35)];
        _view3.layer.borderWidth = 1.f;
        _view3.layer.borderColor = K_MAINCOLOR.CGColor;
        [cell addSubview:_view3];
        
        NSArray *array3 = @[[UIColor grayColor],[UIColor purpleColor],[UIColor colorWithRed:255/255.0 green:128/255.0 blue:128/255. alpha:1.],[UIColor blueColor],[UIColor greenColor],[UIColor blackColor],[UIColor cyanColor],[UIColor yellowColor],[UIColor whiteColor],[UIColor orangeColor]];
        int m = 0;
        for (int i  = 0; i < 10; i ++) {
            UIButton *colorButton = [UIButton buttonWithFrame:CGRectMake(20 * i + 112, 100, 16, 30) Title:nil color:[array3 objectAtIndex:m ++] image:nil];
            colorButton.imageEdgeInsets = UIEdgeInsetsMake(8, 0, 8, 0);
            colorButton.tag = 600 + i;
            [cell addSubview:colorButton];
            [colorButton addTarget:self action:@selector(colorButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 85, 120)];
        _imageView.image = [UIImage imageWithContentsOfFile:self.getImagePath];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.layer.borderWidth = 1.;
        _imageView.layer.borderColor = K_MAINCOLOR.CGColor;
        [cell addSubview:_imageView];
        
    } else if (indexPath.section == 1) {
        //子分类输入框
        self.childTextField = [[[UITextField alloc]initWithFrame:CGRectMake(10, 3, 300, 30)] autorelease];
        _childTextField.returnKeyType = UIKeyboardAppearanceDefault;
        _childTextField.layer.borderWidth = .2f;
        _childTextField.layer.borderColor = K_TITLECOLOR.CGColor;
        _childTextField.borderStyle = UITextBorderStyleRoundedRect;
        _childTextField.tag = 10;
        _childTextField.delegate = self;
        [cell addSubview:self.childTextField];

        for (int i = 0; i < self.mArray.count; i ++) {
            UIButton *button = [UIButton buttonWithFrame:CGRectMake(250 - 62 * i, 40, 60, 30) Title:[self.mArray objectAtIndex:i] color:[UIColor whiteColor] image:nil];
            button.tag = 200 + i;
            button.layer.borderWidth = 1.;
            button.layer.borderColor = K_MAINCOLOR.CGColor;
            button.layer.cornerRadius = 10;
            button.showsTouchWhenHighlighted = YES;
            [button addTarget:self action:@selector(childButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.textLabel setNumberOfLines:0];
            
            [cell addSubview:button];
        }
        
    } else if (indexPath.section == 2) {
        
        //品牌
        self.textField = [[[UITextField alloc]initWithFrame:CGRectMake(10, 5, 300, 30)] autorelease];
        _textField.returnKeyType = UIKeyboardAppearanceDefault;
        _textField.layer.borderWidth = .2f;
        _textField.layer.borderColor = K_TITLECOLOR.CGColor;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.tag = 11;
        _textField.delegate = self;
        [cell addSubview:self.textField];
    }else if (indexPath.section == 3) {
        //价格
        self.priceTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, 300, 30)];
        [self.priceTextField retain];
        _priceTextField.borderStyle = UITextBorderStyleRoundedRect;
        _priceTextField.returnKeyType = UIKeyboardAppearanceDefault;
        _priceTextField.tag = 12;
        _priceTextField.delegate = self;
        [cell addSubview:self.priceTextField];
        
    } else if (indexPath.section == 4) {
        self.dataButton = [UIButton buttonWithFrame:CGRectMake(0, 0, 320, 40) Title:@"选择日期" color:[UIColor whiteColor] image:nil];
        [_dataButton addTarget:self action:@selector(dataButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:_dataButton];
        
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
        _dataField.enabled = NO;
        [dateFormatter release];
        [cell addSubview:self.dataField];
    } else if (indexPath.section == 5) {
        self.remarkTextField = [[[UITextField alloc]initWithFrame:CGRectMake(10, 5, 300, 30)] autorelease];
        _remarkTextField.borderStyle = UITextBorderStyleRoundedRect;
        _remarkTextField.returnKeyType = UIKeyboardAppearanceDefault;
        _remarkTextField.tag = 14;
        _remarkTextField.delegate = self;
        [cell addSubview:self.remarkTextField];
        
    }
    //    UIActionSheet *
    //    UIImagePickerController *
    return cell;
}
#pragma mark 清除背景
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

#pragma mark 头view的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor = K_MAINCOLOR;
    if (section == 1) {
        UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"item-info-icon-shape@2x"]];
        imageview.frame = CGRectMake(5, 5, 20, 20);
        [view addSubview:imageview];
        [imageview release];
        UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 60, 30)]autorelease];;
        label.text = @"子分类:";
        [view addSubview:label];
    } else if (section == 2){
        UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"item-info-icon-brand@2x"]];
        imageview.frame = CGRectMake(5, 6, 15, 15);
        [view addSubview:imageview];
        [imageview release];
        UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 60, 30)]autorelease];;
        label.text = @"品牌:";
        [view addSubview:label];
    } else if (section == 3) {
        UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"item-info-icon-price@2x"]];
        imageview.frame = CGRectMake(5, 6, 15, 15);
        [view addSubview:imageview];
        [imageview release];
        UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 60, 30)]autorelease];
        label.text = @"价格:";
        [view addSubview:label];
    } else if (section == 4) {
        UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menu-button-agenda@2x"]];
        imageview.frame = CGRectMake(5, 6, 20, 20);
        [view addSubview:imageview];
        [imageview release];
        UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 60, 30)]autorelease];
        label.text = @"日期:";
        [view addSubview:label];
    } else if (section == 5) {
        UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"item-info-icon-remarks@2x"]];
        imageview.frame = CGRectMake(5, 6, 20, 20);
        [view addSubview:imageview];
        [imageview release];
        UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 60, 30)]autorelease];
        label.text = @"备注:";
        [view addSubview:label];
    }
//    [view release];
    return view;
    
}

#pragma mark 季节点击事件
- (void)seasonButtonAction:(UIButton *)sender
{
    if ([[sender titleColorForState:UIControlStateNormal] isEqual:K_TITLECOLOR]) {
        [sender setTitleColor:K_TEXTCOLOR forState:UIControlStateNormal];
        NSLog(@"%@", sender.titleLabel.text);
        [_seasonArray addObject:sender.titleLabel.text];
    }else {
        [sender setTitleColor:K_TITLECOLOR forState:UIControlStateNormal];
        [_seasonArray removeObject:sender.titleLabel.text];
    }
}

#pragma mark 颜色点击事件
- (void)colorButtonAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 600:
            _colorprintInfo = @"褐";
            break;
        case 601:
            _colorprintInfo = @"紫";
            break;
        case 602:
            _colorprintInfo = @"粉";
            break;
        case 603:
            _colorprintInfo = @"蓝";
            break;
        case 604:
            _colorprintInfo = @"绿";
            break;
        case 605:
            _colorprintInfo = @"黑";
            break;
        case 606:
            _colorprintInfo = @"青";
            break;
        case 607:
            _colorprintInfo = @"黄";
            break;
        case 608:
            _colorprintInfo = @"白";
            break;
        case 609:
            _colorprintInfo = @"橘";
            break;
        default:
            break;
    }
    
//    for (int i = 0; i < 10; i++) {
//        if (sender.tag == 600 + i) {
//            QCheckBox *_check = [[QCheckBox alloc] initWithDelegate:self];
//            _check.frame = CGRectMake(20 * i + 112, 100, 10, 30);
//            [self.view addSubview:_check];
//            [_check setChecked:YES];
//            [_colorArray addObject:_colorprintInfo];
//            [_check addTarget:self action:@selector(checkBoxAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//        }
//    }
    for (int i = 0; i < 10; i++) {
        if (sender.tag == 600 + i) {
            if ([sender imageForState:UIControlStateNormal] == nil) {
                [sender setImage:[UIImage imageNamed:@"check_icon@2x.png"] forState:UIControlStateNormal];
                [_colorArray addObject:_colorprintInfo];
            }else {
                [sender setImage:nil forState:UIControlStateNormal];
                [_colorArray removeObject:_colorprintInfo];
            }
            
            
        }
    }



}
#pragma mark 点击checkBox取消选择颜色
- (void)checkBoxAction:(QCheckBox *)sender
{
    
    [sender setChecked:NO];
}

#pragma mark 图标点击事件
- (void)imageButtonAction:(UIButton *)sender
{
    _buttonSelectedIndex = sender.tag;
    _className = sender.titleLabel.text;
    self.mArray = [[ZXYDBManager sharedDataManager] searchWithClassName:_dict[[NSString stringWithFormat:@"%d", sender.tag]]];
    [self.tableView reloadData];
}

#pragma mark 子分类点击事件
- (void)childButtonAction:(UIButton *)sender
{
    NSString *str = sender.titleLabel.text;
    NSLog(@"%@",str);
    _childTextField.text = sender.titleLabel.text;
    NSLog(@"%@",_childTextField.text);
    for (int i = 0; i < self.mArray.count; i ++) {
        if (sender.tag == i + 200 ) {
            [sender setBackgroundColor:K_MAINCOLOR];
            
        }else {
            
            [(UIButton *)[self.view viewWithTag:i + 200] setBackgroundColor:[UIColor whiteColor]];
        }
    }
    
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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8 * 3600]];
    _dataField.text = [dateFormatter stringFromDate:_datePicker.date];
    [dateFormatter release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}
#pragma mark textfield开始编辑时触发
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}
#pragma mark textfield结束编辑时触发
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 12) {
        NSLog(@"%@", _priceTextField.text);
        _price = [NSMutableString stringWithString:_priceTextField.text];
    }
    [self animateTextField: textField up: NO];
}
#pragma mark textfield上移
- (void) animateTextField: (UITextField*) textField up: (BOOL) up

{
    int movementDistance = 0;
    if (textField.tag == 10) {
        movementDistance = 100; // tweak as needed
        
    } else if (textField.tag == 13) {
        movementDistance = 120;
    } else if (textField.tag == 14) {
        movementDistance=240;
    } else {
        movementDistance =150;
    }
    const float movementDuration = 0.3f; // tweak as needed
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    
    [UIView setAnimationBeginsFromCurrentState: YES];
    
    [UIView setAnimationDuration: movementDuration];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
    
}

#pragma mark 判断输入的价格是不是浮点型
- (BOOL)isValidDouble:(NSString *)str
{
    NSString *doubleRegex = @"^[1-9]d*.d*|0.d*[1-9]d*$";
    NSPredicate *doubleTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", doubleRegex];
    return [doubleTest evaluateWithObject:str];;
}
#pragma mark 判断输入的价格是不是整数
- (BOOL)isValidInt:(NSString *)str
{
    NSString *intRegex = @"^[0-9]*$";
    NSPredicate *intTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", intRegex];
    return [intTest evaluateWithObject:str];;
}
#pragma mark 完成按钮功能实现
- (void)makeAction:(UIBarButtonItem *)sender
{
    for (NSString *Str in _colorArray) {
        NSLog(@"%@",Str);
    }
    NSString *colorStr = @"";
    for (NSString *str in _colorArray) {
        colorStr = [colorStr stringByAppendingString:str];
    }
    NSString *seasonStr = @"";
    for (NSString *str in _seasonArray) {
        seasonStr = [seasonStr stringByAppendingString:str];
    }
    if (_priceTextField.text.length == 0 || [self isValidDouble:_priceTextField.text] || [self isValidInt:_priceTextField.text]) {
        NSLog(@"%@", _priceTextField.text);
        [[ZXYDBManager sharedDataManager] insertSubClassWithParent:_className withSubClassName:_childTextField.text];
        [[ZXYDBManager sharedDataManager] insertClothes:self.getImagePath withClassification:_className withSubClassification:_childTextField.text withSeason:seasonStr withColor:colorStr withBrand:_textField.text withPrice:_priceTextField.text withDate:_datePicker.date withRemarks:_remarkTextField.text];
        

        [ZXYDBManager sharedDataManager].isCreatNewClothing = YES;
        [ZXYDBManager sharedDataManager].clothingName = _getImagePath;
        [self dismissViewControllerAnimated:NO completion:nil];
        
    } else {
        _priceTextField.text = nil;
        _priceTextField.placeholder = @"请输入正确的价格";
    }
}

#pragma mark 取消按钮功能实现
- (void)cancelAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 取消任务栏显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark 在textField上添加toolBar
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    
    //    UIBarButtonItem * helloButton = [[UIBarButtonItem alloc]initWithTitle:@"Hello" style:UIBarButtonItemStyleBordered target:self action:nil];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [btnSpace release];
    [doneButton release];
    [topView setItems:buttonsArray];
    [textField setInputAccessoryView:topView];
    [topView release];
    return YES;
}
- (void)dismissKeyBoard
{
    [self.view endEditing:YES];
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"155555");
    [textField resignFirstResponder];
    return YES;
}
@end
