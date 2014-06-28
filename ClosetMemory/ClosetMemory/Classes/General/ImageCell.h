//
//  ImageCell.h
//  MushroomStreet
//
//  Created by LLLL on 14-5-23.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultList.h"

@interface ImageCell : UITableViewCell

@property (nonatomic, copy) UIImageView *photoImageView;
@property (nonatomic, copy) UILabel *label;



- (void)setPhotoImage:(ResultList *)list;

//定义cell高度
+ (CGFloat)heighetForImageCell:(ResultList *)list;
- (void)clear;
@end
