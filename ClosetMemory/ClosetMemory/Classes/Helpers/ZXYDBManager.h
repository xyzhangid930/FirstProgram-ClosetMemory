//
//  ZXYDBManager.h
//  ClosetMemory
//
//  Created by zxy on 14-6-18.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "WSClothingModel.h"
#import "WSPersonModel.h"

@interface ZXYDBManager : NSObject

@property (nonatomic, retain) FMDatabase *db;
@property (nonatomic, assign) BOOL isCreatNewClothing;
@property (nonatomic, retain) NSString *clothingName;

#pragma mark 声明创建单例对象的类方法
+ (ZXYDBManager *)sharedDataManager;

#pragma mark 打开数据库
- (void)openDB;

#pragma mark 创建数据表
- (void)createTable;

#pragma mark 插入衣服
- (void)insertClothes:(NSString *)imageName
withClassification:(NSString *)className
withSubClassification:(NSString *)subClassName
        withSeason:(NSString *)season
         withColor:(NSString *)color
         withBrand:(NSString *)brand
         withPrice:(NSString *)price
          withDate:(NSDate *)date
       withRemarks:(NSString *)remarks;

#pragma mark 实现插入子分类
- (void)insertSubClassWithParent:(NSString *)className withSubClassName:(NSString *)subClassName;

#pragma mark 实现插入穿着衣服的数据
- (void)insertPersonModelWithPersonImageName:(NSString *)personImageName withCoatName:(NSString *)coatName withCoatName2:(NSString *)coatName2 withPantsName:(NSString *)pantsName withSkirtName:(NSString *)skirtName withShoesName:(NSString *)shoesName withBagName:(NSString *)bagName withDate:(NSDate *)imageDate withRemarks:(NSString *)remarks withMood:(NSString *)mood;

#pragma mark 删除
- (void)deleteDataWithImageName:(NSString *)imageName;

#pragma mark 查询全部数据
- (NSMutableArray *)searchData;

#pragma mark 实现查询分类数据
- (NSMutableArray *)searchDataWithClassName:(NSString *)className;

#pragma mark 实现查询子分类数据
- (NSMutableArray *)searchDataWithSubClassName:(NSString *)subClassName;

#pragma mark 根据className查询所有子类名
- (NSMutableArray *)searchWithClassName:(NSString *)className;

#pragma mark 查询imageName为指定值的数据的所有信息
- (WSClothingModel *)searchOneDataWithImageName:(NSString *)imageName;

#pragma mark 根据某个字段筛选出PersonModel 可能一个可能多个
- (id)searchFromPersonModel:(NSString *)name withValue:(NSString *)value;

#pragma mark 根据personImageName查询出身上所有衣物
- (NSMutableArray *)searchPersonClothWithPersonModel:(NSString *)personImageName;

#pragma mark 根据试衣间里的数据查询出所有符合条件的PersonModel
- (NSMutableSet *)searchPersonModelWithDress:(NSMutableDictionary *)dressDict;

#pragma mark 按时间分组输出衣物分类
- (NSMutableDictionary *)groupedClothingByDate;

#pragma mark 按季节分组输出衣物分类
- (NSMutableDictionary *)groupedClothingBySeason;

#pragma mark 按品牌分组输出衣物分类
- (NSMutableDictionary *)groupedClothingByBrand;

#pragma mark 按价格分组输出衣物分类
- (NSMutableDictionary *)groupedClothingByPrice;

#pragma mark 按颜色分组输出衣物分类
- (NSMutableDictionary *)groupedClothingByColor;

#pragma mark 根据字符输出颜色
- (UIColor *)getColorFromString:(NSString *)string;

@end
