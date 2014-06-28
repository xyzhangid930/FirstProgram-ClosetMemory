//
//  PhotoCell.h
//  MushroomStreet
//
//  Created by LLLL on 14-5-24.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultList.h"
#import "Photo.h"

@interface PhotoCell : UITableViewCell

@property (nonatomic, retain) UIImageView *photoView;
@property (nonatomic, retain) ResultList *list;

- (void)setPhotoHeight:(ResultList *)resultList index:(NSIndexPath *)indexPath;

@end
