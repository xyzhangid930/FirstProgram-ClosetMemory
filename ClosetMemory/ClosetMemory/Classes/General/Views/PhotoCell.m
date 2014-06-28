//
//  PhotoCell.m
//  MushroomStreet
//
//  Created by LLLL on 14-5-24.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "PhotoCell.h"
#import "UIImageView+WebCache.h"

@implementation PhotoCell

- (void)dealloc
{
    [_photoView release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        for (int i = 0; i < [self.list.photo count]; i++) {
//        }
        
        _photoView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_photoView];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setPhotoHeight:(ResultList *)resultList index:(NSIndexPath *)indexPath
{
//    NSArray *array = resultList.photo;
//    for (NSDictionary *dic in array) {
//        Photo *photo = [[Photo alloc]init];
//        [photo setValuesForKeysWithDictionary:dic];
//        NSString *h = [dic objectForKey:@"h"];
//        NSString *w = [dic objectForKey:@"w"];
//        CGFloat height = [h floatValue];
//        CGFloat width = [w floatValue];
//     self.photoView.frame = CGRectMake(0, 0, 320, height*(320/width));
//        [self.photoView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",photo.img]]];
//    }
    NSString *height = [[resultList.photo objectAtIndex:indexPath.row]objectForKey:@"h"];
    CGFloat h = [height floatValue];
    NSString *width = [[resultList.photo objectAtIndex:indexPath.row]objectForKey:@"w"];
    CGFloat w = [width floatValue];
    self.photoView.frame = CGRectMake(0, 0, 320, h*(320/w));
    [self.photoView setImageWithURL:[NSURL URLWithString:[[resultList.photo objectAtIndex:indexPath.row] objectForKey:@"img"]]];

}


@end
