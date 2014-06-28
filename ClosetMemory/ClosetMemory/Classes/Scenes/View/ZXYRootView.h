//
//  ZXYRootView.h
//  ClosetMemory
//
//  Created by zxy on 14-6-18.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXYRootView : UIView

@property (nonatomic, retain) UITableView *listTableView;      //  抽屉栏
@property (nonatomic, assign) UIPanGestureRecognizer *panGR;   //  平移手势
@property (nonatomic, assign) UITapGestureRecognizer *tapGR;   //  轻拍手势

//  分类按钮
@property (nonatomic, retain) UIButton *allButton;
@property (nonatomic, retain) UIButton *coatButton;
@property (nonatomic, retain) UIButton *pantsButton;
@property (nonatomic, retain) UIButton *skirtButton;
@property (nonatomic, retain) UIButton *shoesButton;
@property (nonatomic, retain) UIButton *bagButton;
@property (nonatomic, retain) UIButton *accessoryButton;

@property (nonatomic, retain) UITableView *subClassTableView;   //  子分类视图
@property (nonatomic, retain) UIScrollView *scrollView;         //  衣物展示
@property (nonatomic, retain) UIButton *mirrorButton;           //  穿衣镜按钮

@property (nonatomic, retain) UILabel *numberLabel;             //  衣服数量标签

//  穿衣View
@property (nonatomic, retain) UILabel *dressLabel;  //  试衣间
@property (nonatomic, retain) UIView *dressView;    //  试衣间框
@property (nonatomic, retain) UIImageView *headView;
@property (nonatomic, retain) UIImageView *coatView;
@property (nonatomic, retain) UIImageView *pantsView;
@property (nonatomic, retain) UIImageView *shoesView;
@property (nonatomic, retain) UIImageView *bagView;
@property (nonatomic, retain) UIImageView *coat2View;
@property (nonatomic, retain) UIImageView *skirtView;
@property (nonatomic, retain) UIView *outView; //  边界
@property (nonatomic, retain) UIView *personView; //  穿衣边界

@end
