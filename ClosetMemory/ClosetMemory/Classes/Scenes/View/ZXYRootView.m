//
//  ZXYRootView.m
//  ClosetMemory
//
//  Created by zxy on 14-6-18.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ZXYRootView.h"

@interface ZXYRootView ()

- (void)addAllViews;

@end

@implementation ZXYRootView

- (void)dealloc
{
    [_allButton release];
    [_coatButton release];
    [_pantsButton release];
    [_skirtButton release];
    [_shoesButton release];
    [_bagButton release];
    [_scrollView release];
    [_subClassTableView release];
    [_mirrorButton release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addAllViews];
        self.backgroundColor = K_MAINBACKGROUNDCOLOR;
    }
    return self;
}

- (void)addAllViews
{
    self.panGR = [[[UIPanGestureRecognizer alloc] init] autorelease];
    [self addGestureRecognizer:_panGR];
    
    //  数量标签
    self.numberLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 45, CGRectGetWidth(self.frame), KHeight)] autorelease];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    //    _numberLabel.backgroundColor = K_MAINCOLOR;
    _numberLabel.alpha = 0.7f;
    //    _numberLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    //    _numberLabel.layer.borderWidth = 4;
    //    _numberLabel.layer.cornerRadius = 5;
    [self addSubview:_numberLabel];
    
    self.listTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 44, KWidth * 4, CGRectGetHeight(self.frame)) style:UITableViewStylePlain] autorelease];
    _listTableView.alpha = 0;
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table-view-bottom.png"]] autorelease];
    _listTableView.tag = 300;
    [self addSubview:_listTableView];
    
    self.coatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _coatButton.frame = CGRectMake(KMargin, CGRectGetMaxY(_numberLabel.frame) + KHeight, KWidth, KHeight);
    [_coatButton setBackgroundImage:[UIImage imageNamed:@"category-icon-100.png"] forState:UIControlStateNormal];
    _coatButton.tag = 100;
    [self addSubview:_coatButton];
    
    self.pantsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _pantsButton.frame = CGRectMake(KMargin, CGRectGetMaxY(_coatButton.frame) + KMargin, KWidth, KHeight);
    [_pantsButton setBackgroundImage:[UIImage imageNamed:@"category-icon-style2-101.png"] forState:UIControlStateNormal];
    _pantsButton.tag = 101;
    [self addSubview:_pantsButton];
    
    self.skirtButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _skirtButton.frame = CGRectMake(KMargin, CGRectGetMaxY(_pantsButton.frame) + KMargin, KWidth, KHeight);
    [_skirtButton setBackgroundImage:[UIImage imageNamed:@"category-icon-style2-102.png"] forState:UIControlStateNormal];
    _skirtButton.tag = 102;
    [self addSubview:_skirtButton];
    
    self.shoesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shoesButton.frame = CGRectMake(KMargin, CGRectGetMaxY(_skirtButton.frame) + KMargin, KWidth, KHeight);
    [_shoesButton setBackgroundImage:[UIImage imageNamed:@"category-icon-style2-103.png"] forState:UIControlStateNormal];
    _shoesButton.tag = 103;
    [self addSubview:_shoesButton];
    
    self.bagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _bagButton.frame = CGRectMake(KMargin, CGRectGetMaxY(_shoesButton.frame) + KMargin, KWidth, KHeight);
    [_bagButton setBackgroundImage:[UIImage imageNamed:@"category-icon-style2-104.png"] forState:UIControlStateNormal];
    _bagButton.tag = 104;
    [self addSubview:_bagButton];
    
    self.accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _accessoryButton.frame = CGRectMake(KMargin, CGRectGetMaxY(_bagButton.frame) + KMargin, KWidth, KHeight);
    [_accessoryButton setBackgroundImage:[UIImage imageNamed:@"category-icon-style2-105.png"] forState:UIControlStateNormal];
    _accessoryButton.tag = 105;
    [self addSubview:_accessoryButton];
    
    self.allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _allButton.frame = CGRectMake(KMargin, CGRectGetMaxY(_accessoryButton.frame) + KMargin, KWidth, KHeight);
    [_allButton setTitle:@"All" forState:UIControlStateNormal];
    [_allButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    _allButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.f];
    [self addSubview:_allButton];
    
    //  图片显示
    self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_coatButton.frame), CGRectGetMaxY(_numberLabel.frame) + 2, CGRectGetMaxX(self.frame) - CGRectGetMaxX(_coatButton.frame) - 3, CGRectGetHeight(self.frame) - KHeight * 8)] autorelease];
    _scrollView.layer.borderColor = [UIColor orangeColor].CGColor;
    _scrollView.layer.borderWidth = 2;
    _scrollView.layer.cornerRadius = 5;
    _scrollView.showsVerticalScrollIndicator = NO;
    //    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    
    //  轻拍手势
    self.tapGR = [[[UITapGestureRecognizer alloc] init] autorelease];
    [self.scrollView addGestureRecognizer:_tapGR];
    
    //  子分类显示
    self.subClassTableView = [[[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) - KWidth - KMargin * 2 - 3, CGRectGetMaxY(_numberLabel.frame) + 2, KWidth + KMargin * 2, CGRectGetHeight(_scrollView.frame)) style:UITableViewStylePlain] autorelease];
    _subClassTableView.bounces = NO;
    _subClassTableView.showsVerticalScrollIndicator = NO;
    _subClassTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _subClassTableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table-view-bottom.png"]] autorelease];
    _subClassTableView.layer.borderWidth = 2;
    _subClassTableView.layer.borderColor = [UIColor orangeColor].CGColor;
    _subClassTableView.layer.cornerRadius = 3;
    _subClassTableView.tag = 301;
    _subClassTableView.alpha = 0;
    [self addSubview:_subClassTableView];
    
    //穿衣View
    self.dressLabel = [[[UILabel alloc] initWithFrame:CGRectMake(KMargin, CGRectGetMaxY(_scrollView.frame) + KMargin, KWidth, KHeight * 4)] autorelease];
    _dressLabel.numberOfLines = 0;
    _dressLabel.textAlignment = NSTextAlignmentCenter;
    _dressLabel.text = @"试衣间";
    _dressLabel.font = [UIFont systemFontOfSize:25.f];
    [self addSubview:_dressLabel];
    
    
    // 上衣
    UIImageView *coatIconView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_scrollView.frame) + KWidth * 2 + KMargin, CGRectGetMaxY(_scrollView.frame) + KMargin, KWidth + KMargin * 2, KHeight + KMargin * 2)];
    [self addSubview:coatIconView];
    coatIconView.image = [UIImage imageNamed:@"iconfont-baobeiNF"];
    self.coatView = [[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_scrollView.frame) + KWidth * 2 + KMargin + 10, CGRectGetMaxY(_scrollView.frame) + KMargin + 5, KWidth, KHeight + KMargin)] autorelease];

    _coatView.userInteractionEnabled = YES;
    [self addSubview:_coatView];
    [coatIconView release];
    
    //  裤子
    UIImageView *pantsIconView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(coatIconView.frame), CGRectGetMaxY(coatIconView.frame) + KMargin, KWidth + KMargin * 2, KHeight + KMargin * 2)];
    [self addSubview:pantsIconView];
    //    _pantsView.backgroundColor = K_MAINCOLOR;
    pantsIconView.image = [UIImage imageNamed:@"iconfont-kuzi"];
    self.pantsView = [[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(pantsIconView.frame) + 10, CGRectGetMinY(pantsIconView.frame) + 5, KWidth, KHeight + KMargin)] autorelease];
    _pantsView.userInteractionEnabled = YES;
    [self addSubview:_pantsView];
    //    _pantsView.backgroundColor = K_MAINCOLOR;
    [pantsIconView release];
    
    
    //  鞋
    UIImageView *shoesIconView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(pantsIconView.frame), CGRectGetMaxY(pantsIconView.frame) + 5, KWidth + KMargin * 2, KHeight)];
    [self addSubview:shoesIconView];
    //    _shoesView.backgroundColor = K_MAINCOLOR;
    shoesIconView.image = [UIImage imageNamed:@"iconfont-gaogenxie"];
    self.shoesView = [[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(shoesIconView.frame) + 10, CGRectGetMinY(shoesIconView.frame), KWidth, KHeight)] autorelease];
    _shoesView.userInteractionEnabled = YES;
    [self addSubview:_shoesView];
    [shoesIconView release];
    
    //  包
    UIImageView *bagIconView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pantsIconView.frame) + KMargin + 2, CGRectGetMinY(pantsIconView.frame), KWidth + KMargin + 5, KHeight + KMargin + 5)];
    [self addSubview:bagIconView];
    bagIconView.image = [UIImage imageNamed:@"iconfont-nvbao"];
    self.bagView = [[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(bagIconView.frame) + 8, CGRectGetMinY(bagIconView.frame)+3, KWidth, KHeight)] autorelease];
    _bagView.userInteractionEnabled = YES;
    [self addSubview:_bagView];
    [bagIconView release];
    
    //  上衣2
    UIImageView *coat2IconView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(coatIconView.frame), CGRectGetMinY(coatIconView.frame) - 5, KImageWidth, KHeight * 2)];
    [self addSubview:coat2IconView];
    coat2IconView.image = [UIImage imageNamed:@"iconfont-shangyi"];
    self.coat2View = [[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(coat2IconView.frame) + 19, CGRectGetMinY(coat2IconView.frame) + 10, KWidth, KHeight + KMargin)] autorelease];
    _coat2View.userInteractionEnabled = YES;
    [self addSubview:_coat2View];
    [coat2IconView release];
    
    //  裙子
    UIImageView *skirtIconView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_scrollView.frame), CGRectGetMinY(coat2IconView.frame) + KWidth, KImageWidth, KImageHeight)];
    [self addSubview:skirtIconView];
    skirtIconView.image = [UIImage imageNamed:@"iconfont-lianyiqun"];
    self.skirtView = [[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(skirtIconView.frame) + 30, CGRectGetMinY(skirtIconView.frame), KWidth,KHeight + KMargin)] autorelease];
    _skirtView.center = skirtIconView.center;
    _skirtView.userInteractionEnabled = YES;
    [self addSubview:_skirtView];
    [skirtIconView release];
    
    self.mirrorButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _mirrorButton.frame = CGRectMake(CGRectGetMaxX(bagIconView.frame) + KMargin, CGRectGetMinY(coatIconView.frame), KImageWidth, CGRectGetHeight(self.frame) - CGRectGetMaxY(_scrollView.frame) - 20);
    [_mirrorButton setBackgroundImage:[UIImage imageNamed:@"mirror"] forState:UIControlStateNormal];
//    [_mirrorButton setTitle:@"" forState:UIControlStateNormal];
    [self addSubview:_mirrorButton];
    
    self.outView =  [[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_scrollView.frame), CGRectGetMaxY(_scrollView.frame)- 20, 1000, 20)] autorelease];
    _outView.backgroundColor = K_MAINBACKGROUNDCOLOR;
    
    [self insertSubview:_outView atIndex:0];
    
    self.dressView = [[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_scrollView.frame), CGRectGetMaxY(_scrollView.frame), CGRectGetWidth(_scrollView.frame), CGRectGetHeight(self.frame) - CGRectGetMaxY(_scrollView.frame) - 5)] autorelease];
    [self insertSubview:_dressView aboveSubview:_outView];
    _dressView.layer.borderColor = [UIColor orangeColor].CGColor;
    _dressView.layer.borderWidth = 2;
    _dressView.layer.cornerRadius = 5;
    
    self.personView = [[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_skirtView.frame) - 5, CGRectGetMinY(_coatView.frame) - 20, KWidth * 9, KHeight * 8)] autorelease];
    //    _personView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shiyijian"]];
    
    [self insertSubview:_personView atIndex:1];
    
    
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
