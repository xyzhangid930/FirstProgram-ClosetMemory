//
//  ResultList.h
//  MushroomStreet
//
//  Created by LLLL on 14-5-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultList : NSObject

@property (nonatomic, copy) NSString *cfav;
@property (nonatomic, copy) NSString *cforward;
@property (nonatomic, copy) NSString *content;  //目录
@property (nonatomic, copy) NSString *created;  //编号
@property (nonatomic, copy) NSString *creply;
@property (nonatomic, copy) NSString *isfaved;
@property (nonatomic, copy) NSArray *photo;    //相片（达人）
@property (nonatomic, copy) NSDictionary *show; //展示图片 价格
@property (nonatomic, copy) NSString *showContent;  //显示标题
@property (nonatomic, copy) NSDictionary *showLarge;    //展示大图片
@property (nonatomic, copy) NSArray *single;
@property (nonatomic, copy) NSDictionary *tags;     //标签
//@property (nonatomic, copy) NSString *trace_id;     //标题id
@property (nonatomic, copy) NSString *trackld;      //识别    与参数track_code有关
@property (nonatomic, copy) NSString *twitterld;    //
@property (nonatomic, copy) NSDictionary *user;     //用户

//@property (nonatomic, copy) NSString *topLeftIcon;  //左上标签图



@end
