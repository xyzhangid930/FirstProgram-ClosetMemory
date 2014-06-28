//
//  DataRequest.h
//  MushroomStreet
//
//  Created by LLLL on 14-5-22.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultList.h"

@interface DataRequest : NSObject

@property (nonatomic, retain) NSMutableArray *showArray;

+ (DataRequest *)shareRequest;


- (NSMutableArray *)requestData:(NSData *)data;

//- (NSData *)getData;

//返回cell的数量
- (NSInteger)quiltViewNumberOfCell;


- (ResultList *)ForRowAtIndexPath:(NSIndexPath *)indexPath;


@end
