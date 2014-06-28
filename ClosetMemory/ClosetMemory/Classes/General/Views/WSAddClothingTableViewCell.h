//
//  WSAddClothingTableViewCell.h
//  ClosetMemory
//
//  Created by 王顺 on 14-6-26.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSAddClothingTableViewCell : UITableViewCell

@property (nonatomic, retain) UITextField *textField; //品牌
@property (nonatomic, retain) UITextField *priceTextField;
@property (nonatomic, retain) UITextField *dataField;
@property (nonatomic, retain) UITextField *childTextField;
@property (nonatomic, retain) UITextField *remarkTextField;//备注
@property (nonatomic, retain) UIView *datePickerView;
@property (nonatomic, retain) UIButton *dataButton;

@end
