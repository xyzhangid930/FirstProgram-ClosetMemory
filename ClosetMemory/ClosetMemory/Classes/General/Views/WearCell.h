//
//  WearCell.h
//  MushroomStreet
//
//  Created by LLLL on 14-5-23.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultList.h"

@interface WearCell : UITableViewCell

@property (nonatomic, copy) UILabel *titleLabel;    //标题
@property (nonatomic, copy) UILabel *priceLabel;    //价钱

- (void)setLabelText:(ResultList *)list index:(NSIndexPath *)indexPath;

@end
