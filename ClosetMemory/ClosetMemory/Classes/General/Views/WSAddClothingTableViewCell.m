////
////  WSAddClothingTableViewCell.m
////  ClosetMemory
////
////  Created by 王顺 on 14-6-26.
////  Copyright (c) 2014年 lanou3g. All rights reserved.
////
//
//#import "WSAddClothingTableViewCell.h"
//
//@interface WSAddClothingTableViewCell ()
//{
//    UIView *_view1;
//    UIView *_view2;
//    UIView *_view3;
//    UIImageView *_imageView;
//    NSInteger _buttonSelectedIndex;
//    NSString *_className;
//    NSMutableString *_price;
//}
//@end
//
//@implementation WSAddClothingTableViewCell
//
//
//
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self addAllViews];
//    }
//    return self;
//}
//
//- (void)addAllViews
//{
//    _view1 = [[[UIView alloc] initWithFrame:CGRectMake(100, 15, 210, 30)] autorelease];
//    _view1.layer.borderWidth = 1.f;
//    _view1.layer.borderColor = K_MAINCOLOR.CGColor;
//    
//    for (int i = 0 ; i < 6; i ++) {
//        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        imageButton.frame = CGRectMake(35 * i + 110, 20, 20, 20);
//        imageButton.tag = 100 + i;
//        imageButton.titleLabel.text = _dict[[NSString stringWithFormat:@"%d", imageButton.tag]];
//        if (_buttonSelectedIndex == imageButton.tag) {
//            [imageButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"category-icon-%d", i + 100]] forState:UIControlStateNormal];
//        } else {
//            [imageButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"category-icon-style2-%d", i + 100]] forState:UIControlStateNormal];
//        }
//        [imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:imageButton];
//    }
//    
//    _view2 = [[UIView alloc] initWithFrame:CGRectMake(100, 55, 210, 30)];
//    _view2.layer.borderWidth = 1.f;
//    _view2.layer.borderColor = K_MAINCOLOR.CGColor;
//    [cell addSubview:_view2];
//    
//    NSArray *seasonArray1 = @[@"春",@"夏",@"秋",@"冬"];
//    int j = 0;
//    for (int i = 0; i < 4; i ++) {
//        UIButton *seasonButton = [UIButton buttonWithFrame:CGRectMake(50 * i + 120, 60, 20, 20) Title:[seasonArray1 objectAtIndex:j ++] color:nil image:nil];
//        [seasonButton setTitleColor:K_TITLECOLOR forState:UIControlStateNormal];
//        [seasonButton addTarget:self action:@selector(seasonButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:seasonButton];
//    }
//    
//    
//    _view3 = [[UIView alloc] initWithFrame:CGRectMake(100, 98, 210, 35)];
//    _view3.layer.borderWidth = 1.f;
//    _view3.layer.borderColor = K_MAINCOLOR.CGColor;
//    [cell addSubview:_view3];
//    
//    NSArray *array3 = @[[UIColor grayColor],[UIColor purpleColor],[UIColor colorWithRed:255/255.0 green:128/255.0 blue:128/255. alpha:1.],[UIColor blueColor],[UIColor greenColor],[UIColor blackColor],[UIColor cyanColor],[UIColor yellowColor],[UIColor whiteColor],[UIColor orangeColor]];
//    int m = 0;
//    for (int i  = 0; i < 10; i ++) {
//        UIButton *colorButton = [UIButton buttonWithFrame:CGRectMake(20 * i + 112, 100, 16, 30) Title:nil color:[array3 objectAtIndex:m ++] image:nil];
//        colorButton.tag = 600 + i;
//        [cell addSubview:colorButton];
//        [colorButton addTarget:self action:@selector(colorButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 85, 120)];
//    _imageView.image = [UIImage imageWithContentsOfFile:self.getImagePath];
//    _imageView.layer.borderWidth = 1.;
//    _imageView.layer.borderColor = K_MAINCOLOR.CGColor;
//    [cell addSubview:_imageView];
//    
//} else if (indexPath.section == 1) {
//    //子分类输入框
//    self.childTextField = [[[UITextField alloc]initWithFrame:CGRectMake(10, 3, 300, 30)] autorelease];
//    _childTextField.returnKeyType = UIKeyboardAppearanceDefault;
//    _childTextField.layer.borderWidth = .2f;
//    _childTextField.layer.borderColor = K_TITLECOLOR.CGColor;
//    _childTextField.borderStyle = UITextBorderStyleRoundedRect;
//    _childTextField.tag = 10;
//    _childTextField.delegate = self;
//    [cell addSubview:self.childTextField];
//    
//    for (int i = 0; i < self.mArray.count; i ++) {
//        UIButton *button = [UIButton buttonWithFrame:CGRectMake(250 - 62 * i, 40, 60, 30) Title:[self.mArray objectAtIndex:i] color:[UIColor whiteColor] image:nil];
//        button.tag = 200 + i;
//        button.layer.borderWidth = 1.;
//        button.layer.borderColor = K_MAINCOLOR.CGColor;
//        button.layer.cornerRadius = 10;
//        button.showsTouchWhenHighlighted = YES;
//        [button addTarget:self action:@selector(childButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.textLabel setNumberOfLines:0];
//        
//        [cell addSubview:button];
//    }
//    
//} else if (indexPath.section == 2) {
//    
//    //品牌
//    self.textField = [[[UITextField alloc]initWithFrame:CGRectMake(10, 5, 300, 30)] autorelease];
//    _textField.returnKeyType = UIKeyboardAppearanceDefault;
//    _textField.layer.borderWidth = .2f;
//    _textField.layer.borderColor = K_TITLECOLOR.CGColor;
//    _textField.borderStyle = UITextBorderStyleRoundedRect;
//    _textField.tag = 11;
//    _textField.delegate = self;
//    [cell addSubview:self.textField];
//}else if (indexPath.section == 3) {
//    //价格
//    self.priceTextField = [[[UITextField alloc]initWithFrame:CGRectMake(10, 5, 300, 30)] autorelease];
//    _priceTextField.borderStyle = UITextBorderStyleRoundedRect;
//    _priceTextField.returnKeyType = UIKeyboardAppearanceDefault;
//    _priceTextField.tag = 12;
//    _priceTextField.delegate = self;
//    [cell addSubview:self.priceTextField];
//    
//} else if (indexPath.section == 4) {
//    self.dataButton = [UIButton buttonWithFrame:CGRectMake(0, 0, 320, 40) Title:@"选择日期" color:[UIColor whiteColor] image:nil];
//    [_dataButton addTarget:self action:@selector(dataButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [cell addSubview:_dataButton];
//    
//    self.dataField = [[[UITextField alloc]initWithFrame:CGRectMake(10, 5, 300, 30)] autorelease];
//    _dataField.borderStyle = UITextBorderStyleRoundedRect;
//    _dataField.returnKeyType = UIKeyboardAppearanceDefault;
//    _dataField.tag = 13;
//    _dataField.delegate = self;
//    _dataField.placeholder = @"年-月-日";
//    _dataField.textAlignment = NSTextAlignmentCenter;
//    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    [dateFormatter setDateFormat:@"yyyy年    MM月    dd日"];
//    _dataField.text = [dateFormatter stringFromDate:[NSDate date]];
//    _dataField.enabled = NO;
//    [dateFormatter release];
//    [cell addSubview:self.dataField];
//} else if (indexPath.section == 5) {
//    self.remarkTextField = [[[UITextField alloc]initWithFrame:CGRectMake(10, 5, 300, 30)] autorelease];
//    _remarkTextField.borderStyle = UITextBorderStyleRoundedRect;
//    _remarkTextField.returnKeyType = UIKeyboardAppearanceDefault;
//    _remarkTextField.tag = 14;
//    _remarkTextField.delegate = self;
//    [cell addSubview:self.remarkTextField];
//    
//}
//
//}
//
//
//- (void)awakeFromNib
//{
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//@end
