//
//  ImageCell.m
//  MushroomStreet
//
//  Created by LLLL on 14-5-23.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ImageCell.h"
#import "UIImageView+WebCache.h"

@implementation ImageCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //图片框架
        _photoImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_photoImageView];
        _label = [[UILabel alloc]initWithFrame:CGRectZero];
        _label.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setPhotoImage:(ResultList *)list
{
    NSString *str = [list.showLarge objectForKey:@"img"];

    [_photoImageView setImageWithURL:[NSURL URLWithString:str]];
    NSString *height = [list.showLarge objectForKey:@"h"];
    CGFloat h = [height floatValue];
    NSString *width = [list.showLarge objectForKey:@"w"];
    CGFloat w = [width floatValue];
    self.photoImageView.frame = CGRectMake(0, 0, 320, h*(320/w));
    [self.photoImageView setImageWithURL:[NSURL URLWithString:[list.showLarge objectForKey:@"img"]]];

    if ([list.single count] == 0) {
        _label.text = @"";
    }else{
    _label.frame = CGRectMake(30, _photoImageView.frame.size.height, 100, 20);

    _label.text = [NSString stringWithFormat:@"共%d件穿搭",[list.single count]];
        
    }
}




+ (CGFloat)heighetForImageCell:(ResultList *)list
{
    NSString *height = [list.showLarge objectForKey:@"h"];
    CGFloat h = [height floatValue];
    NSString *width = [list.showLarge objectForKey:@"w"];
    CGFloat w = [width floatValue];

    return (h*(320/w))+ 20;
    
}




- (void)dealloc
{
    [_photoImageView release];
    [_label release];
    [super dealloc];
}
- (void)clear
{
    self.photoImageView.image = nil;
    _label.text = nil;
}
@end
