//
//  NetWorkConnect_Delegate.h
//  Test724_Json_xml
//
//  Created by lizhongren on 13-7-24.
//  Copyright (c) 2013年 lzhr. All rights reserved.
//

#import <SystemConfiguration/SystemConfiguration.h>
#import <Foundation/Foundation.h>


@protocol netWorkDelegate <NSObject>

-(void)successfulGetData:(NSData*)data;

@optional
-(void)failedGetData:(NSError*)error;

@end


@interface NetWorkConnect_Delegate : NSObject

@property(nonatomic,retain)NSMutableData * receiveData;
@property(nonatomic,retain)NSURLConnection * connection;
@property(nonatomic,assign)id<netWorkDelegate> delegate;

-(void)getRequestForURLString:(NSString *)string;
-(void)postRequestForURLString:(NSString *)string withBody:(NSData *)body;

//
-(void)connectCancel;

@end
