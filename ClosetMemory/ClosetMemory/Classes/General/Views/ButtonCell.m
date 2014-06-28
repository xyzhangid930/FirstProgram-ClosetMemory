//
//  ButtonCell.m
//  MushroomStreet
//
//  Created by LLLL on 14-5-23.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell

- (void)dealloc
{
    [super dealloc];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //评论
        _commentsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _commentsBtn.frame = CGRectMake(0, 5, 60, 20);
        _commentsBtn.tintColor = [UIColor grayColor];
        
        [_commentsBtn setTitle:@"评论" forState:UIControlStateNormal];
        [_commentsBtn addTarget:self action:@selector(commentsBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_commentsBtn];
        
        //喜欢
        _likeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _likeBtn.frame = CGRectMake(80, 5, 60, 20);
        _likeBtn.tintColor = [UIColor grayColor];
        
        [_likeBtn setTitle:@"喜欢" forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(likeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_likeBtn];
        
        //专辑
        _albumBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _albumBtn.frame = CGRectMake(160, 5, 60, 20);
        _albumBtn.tintColor = [UIColor grayColor];
        
        [_albumBtn setTitle:@"专辑" forState:UIControlStateNormal];
        [_albumBtn addTarget:self action:@selector(albumBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_albumBtn];

        //分享
        _shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _shareBtn.frame = CGRectMake(240, 5, 60, 20);
        _shareBtn.tintColor = [UIColor grayColor];
        
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_shareBtn];

        
        
    }
    return self;
}

- (void)commentsBtn:(UIButton *)button
{
    NSLog(@"评论");
//    MyViewController *myVC = [[MyViewController alloc]init];
    
    
}

- (void)likeBtn:(UIButton *)button
{
    NSLog(@"喜欢");
    [button setTitle:@"已喜欢" forState:UIControlStateNormal];
//    [button setTitle:@"喜欢" forState:UIControlStateNormal];
    
}

- (void)albumBtn:(UIButton *)button
{
    NSLog(@"专辑");
}

- (void)shareBtn:(UIButton *)button
{
    NSLog(@"分享");

//    NSString *str = [self.list.showLarge objectForKey:@"img"];
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    UIImage *image = [UIImage imageWithData:data];
    
//    id<ISSContent> publishContent = [ShareSDK content:nil
//                                       defaultContent:nil
//                                                image:nil
//                                                title:nil
//                                                  url:nil
//                                          description:nil
//                                            mediaType:SSPublishContentMediaTypeText];
//    
//    
//    [ShareSDK showShareActionSheet:nil shareList:nil content:publishContent statusBarTips:NO authOptions:nil
//                      shareOptions:nil
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                if (state == SSPublishContentStateSuccess) {
//                                    NSLog(@"分享成功");
//                                }else if (state == SSPublishContentStateFail){
//                                    NSLog(@"分享失败");
//                                }
//                            }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
