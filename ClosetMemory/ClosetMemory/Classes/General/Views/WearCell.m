//
//  WearCell.m
//  MushroomStreet
//
//  Created by LLLL on 14-5-23.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "WearCell.h"
#define kTopSpacing 10
#define kDownSpacing 10
#define kLeftSpacing 100
#define kRinghtSpacing 10
#define kLabelHeight  30

@implementation WearCell

- (void)dealloc
{
    [_titleLabel release];
    [_priceLabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftSpacing, kTopSpacing, 200, kLabelHeight)];
        _titleLabel.font = [UIFont systemFontOfSize:11];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftSpacing, kTopSpacing+kLabelHeight , 100, kLabelHeight)];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textColor =  [UIColor colorWithRed:229/255.0 green:45/255.0 blue:149/255.0 alpha:1];
        [self.contentView addSubview:_priceLabel];
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//
- (void)setLabelText:(ResultList *)list index:(NSIndexPath *)indexPath
{
    _titleLabel.text = [[list.single objectAtIndex:indexPath.row-1]objectForKey:@"title"];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    _priceLabel.text = [[list.single objectAtIndex:indexPath.row-1]objectForKey:@"price"];
}
@end
