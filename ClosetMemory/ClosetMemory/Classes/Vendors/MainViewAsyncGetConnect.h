//
//  MainViewAsyncGetConnect.h
//  DressCollocation
//
//  Created by yuhang on 14-1-18.
//  Copyright (c) 2014年 yuhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol back;
@interface MainViewAsyncGetConnect : NSObject
{
    NSMutableData * _receiveData;
    
    NSURLConnection * _con;
}

-(void)startConnect:(NSString *)interface;
-(void)Connection;
@property(nonatomic,assign) id<back>delegate;

@property (nonatomic,retain)NSString * identifier;//

@end


@protocol back <NSObject>

-(void)backData:(NSMutableData *)data;

@optional
- (void)backData:(NSMutableData *)data withIdentifier:(NSString *)identifier;


@end
