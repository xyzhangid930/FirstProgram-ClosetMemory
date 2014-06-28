//
//  MainViewAsyncGetConnect.m
//  DressCollocation
//
//  Created by yuhang on 14-1-18.
//  Copyright (c) 2014年 yuhang. All rights reserved.
//
#import "MainViewAsyncGetConnect.h"
@implementation MainViewAsyncGetConnect

-(id)init{
    if ([super init]) {
        
        }
    return self;
}


//开始网络请求    异步
-(void)startConnect:(NSString *)interface{
    //1.接口地址
    NSString * str = interface;
    //2.转成URL
    NSURL * url = [NSURL URLWithString:str];
    //3.网络请求方式设置如下
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    //4.请求方式
    [request setHTTPMethod:@"GET"];  //请求方式  设置成GET
    //5.设置连接方式
    _con = [NSURLConnection connectionWithRequest:request delegate:self];
}
-(void)Connection
{
    [_con cancel];
}
//获取此响应response
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    _receiveData = [[NSMutableData alloc] init]; //响应的时候初始化
 }

//获得数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_receiveData appendData:data];
}

//结束  判断是否接收数据
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self.delegate backData:_receiveData];
    
    
    
}
@end
