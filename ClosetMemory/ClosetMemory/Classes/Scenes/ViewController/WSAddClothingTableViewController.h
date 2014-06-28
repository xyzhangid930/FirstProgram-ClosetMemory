//
//  WSAddClothingTableViewController.h
//  ClosetMemory
//
//  Created by wangshun on 14-6-18.
//  Copyright (c) 2014年 2014蓝鸥20班. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSClothingModel.h"
#import "QCheckBox.h"
@interface WSAddClothingTableViewController : UITableViewController


@property (nonatomic, retain) NSMutableArray *mArray;


@property (nonatomic, retain) NSString *getImagePath;//从相机中获得的图片路径
@property (nonatomic, retain) UIDatePicker *datePicker;


@property (nonatomic, retain) UITextField *textField; //品牌
@property (nonatomic, retain) UITextField *priceTextField;
@property (nonatomic, retain) UITextField *dataField;
@property (nonatomic, retain) UITextField *childTextField;
@property (nonatomic, retain) UITextField *remarkTextField;//备注
@property (nonatomic, retain) UIView *datePickerView;
@property (nonatomic, retain) UIButton *dataButton;


@end
