//
//  ButtonCell.h
//  MushroomStreet
//
//  Created by LLLL on 14-5-23.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultList.h"

@interface ButtonCell : UITableViewCell

@property (nonatomic, retain) UIButton *commentsBtn;    //评论按钮
@property (nonatomic, retain) UIButton *likeBtn;    //喜欢按钮
@property (nonatomic, retain) UIButton *albumBtn;   //专辑按钮
@property (nonatomic, retain) UIButton *shareBtn;   //分享按钮
@property (nonatomic, retain) ResultList *list;


@end
