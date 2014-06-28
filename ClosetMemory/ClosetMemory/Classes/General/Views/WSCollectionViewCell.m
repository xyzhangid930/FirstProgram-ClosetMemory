//
//  WSCollectionViewCell.m
//  UICollectionView
//
//  Created by 王顺 on 14-6-9.
//  Copyright (c) 2014年 王顺. All rights reserved.
//

#import "WSCollectionViewCell.h"

@implementation WSCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

#pragma mark 重写imageView的getter方法
- (UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 20)] autorelease];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

#pragma mark 重写label的getter方法
- (UILabel *)label
{
    if (nil == _label) {
        self.label =  [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.bounds.size.width, 20)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_label];
    }
    return _label;
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
