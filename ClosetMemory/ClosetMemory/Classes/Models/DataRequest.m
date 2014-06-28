//
//  DataRequest.m
//  MushroomStreet
//
//  Created by LLLL on 14-5-22.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "DataRequest.h"

@implementation DataRequest
- (void)dealloc
{
    [_showArray release];
    [super dealloc];
    
}


static DataRequest *request;
+ (DataRequest *)shareRequest
{
    if (request == nil) {
        request = [[DataRequest alloc]init];
    }
    return request;
}

- (NSMutableArray *)requestData:(NSData *)data
{
    self.showArray = [NSMutableArray arrayWithCapacity:10];
    NSError *err = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
    NSArray *list = [[dic objectForKey:@"result"]objectForKey:@"list"];

    for (NSDictionary *item in list) {

        ResultList *resultList = [[ResultList alloc]init];
        [resultList setValuesForKeysWithDictionary:item];
        
        [self.showArray addObject:resultList];
    }
    return self.showArray;
}

- (NSInteger)quiltViewNumberOfCell
{
    return [self.showArray count];
}

- (ResultList *)ForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultList *result = [self.showArray objectAtIndex:indexPath.row];
    return result;
}



@end
