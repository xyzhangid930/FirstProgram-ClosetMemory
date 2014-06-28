//
//  NetWorkConnect_Delegate.m
//  Test724_Json_xml
//
//  Created by lizhongren on 13-7-24.
//  Copyright (c) 2013年 lzhr. All rights reserved.
//

#import "NetWorkConnect_Delegate.h"

@implementation NetWorkConnect_Delegate

-(void)getRequestForURLString:(NSString *)string
{
    NSURL *url =[[NSURL alloc] initWithString:string];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:0 timeoutInterval:20];
    
    [request setHTTPMethod:@"GET"];
    self.connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    [url release];
    [request release];
    [_connection release];
    
}
-(void)postRequestForURLString:(NSString *)string withBody:(NSData *)body
{
    NSURL *url =[[NSURL alloc] initWithString:string];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:0 timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:body];
    self.connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [url release];
    [request release];
    [_connection release];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receiveData = [[NSMutableData alloc] init];
    [_receiveData release];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receiveData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(successfulGetData:)]) {
        [self.delegate successfulGetData:_receiveData];
    }
}
-(void)connectCancel
{
    [_connection cancel];
    [_connection release];
    _connection = nil;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//    [self.delegate failedGetData:error];
}
- (void)dealloc
{
    [_connection release];
    [_receiveData release];
    [super dealloc];
}

@end
