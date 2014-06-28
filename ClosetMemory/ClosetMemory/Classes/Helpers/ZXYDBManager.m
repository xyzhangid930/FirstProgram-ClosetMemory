//
//  ZXYDBManager.m
//  ClosetMemory
//
//  Created by zxy on 14-6-18.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ZXYDBManager.h"

static ZXYDBManager *dataManager = nil;

@implementation ZXYDBManager

#pragma mark 实现创建单例对象的类方法
+ (ZXYDBManager *)sharedDataManager
{
    if (nil == dataManager) {
        dataManager = [[ZXYDBManager alloc] init];
    }
    return dataManager;
}

#pragma mark 打开数据库
- (void)openDB
{
    //  拼接数据库存放的路径
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"ClosetMemory.sqlite"];
    // 判断数据库时候已经存在，如果存在则删除
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager isExecutableFileAtPath:dbPath]) {
        [fileManager removeItemAtPath:dbPath error:Nil];
    }
    // 创建新的数据库
    self.db = [FMDatabase databaseWithPath:dbPath];
    if (![_db open]) {
        NSLog(@"Could not open db");
        return;
    }
}

#pragma mark 实现创建数据表
- (void)createTable
{
    if ([self.db executeUpdate:@"CREATE TABLE Clothes (imageName text, className text, subClassName text, season text, color text, brand text, price text, date text, remarks text)"]) {
        NSLog(@"Create Clothes Successed");
    }
    if ([self.db executeUpdate:@"create table SubClassification (className text, subClassName text)"]) {
        NSLog(@"Create SubClassification Successed");
    }
    if ([self.db executeUpdate:@"create table PersonModel (personImageName text, coatName text, coatName2 text, pantsName text, skirtName text, shoesName text, bagName text, accessoryName text, imageDate date, remarks text, mood text)"]) {
        NSLog(@"create personmodel successed");
    }
}

#pragma mark 实现插入衣服
- (void)insertClothes:(NSString *)imageName
withClassification:(NSString *)className
withSubClassification:(NSString *)subClassName
        withSeason:(NSString *)season
         withColor:(NSString *)color
         withBrand:(NSString *)brand
         withPrice:(NSString *)price
          withDate:(NSDate *)date
       withRemarks:(NSString *)remarks
{
    if ([self.db executeUpdate:@"insert into Clothes (imageName, className, subClassName, season, color, brand, price, date, remarks) values (?, ?, ?, ?, ?, ?, ?, ?, ?)", imageName, className, subClassName, season, color, brand, price, date, remarks]) {
        NSLog(@"insert successed");
    }
}

#pragma mark 实现插入子分类
- (void)insertSubClassWithParent:(NSString *)className withSubClassName:(NSString *)subClassName
{
    NSInteger count = 1;
    //  判断插入的子分类是否已存在
    FMResultSet *resultSet = [self.db executeQuery:@"select subClassName from SubClassification where className = ?", className];
    while ([resultSet next]) {
        NSString *existSubClassName = [resultSet stringForColumn:@"subClassName"];
        if ([existSubClassName isEqualToString:subClassName]) {
            count --;
        }
    }
    if (count && ![subClassName isEqualToString:@""]) {
        if ([self.db executeUpdate:@"insert into SubClassification (className, subClassName) values (?, ?)", className, subClassName]) {
            NSLog(@"insert %@ successed", subClassName);
        }
    }
}

#pragma mark 实现插入穿着衣服的数据
- (void)insertPersonModelWithPersonImageName:(NSString *)personImageName withCoatName:(NSString *)coatName withCoatName2:(NSString *)coatName2 withPantsName:(NSString *)pantsName withSkirtName:(NSString *)skirtName withShoesName:(NSString *)shoesName withBagName:(NSString *)bagName withDate:(NSDate *)imageDate withRemarks:(NSString *)remarks withMood:(NSString *)mood
{
//    NSString *sql = [NSString stringWithFormat:@"insert into PersonModel (personImageName, coatName, coatName2, pantsName, skirtName, shoesName, bagName, accessoryName, imageDate, remarks, mood) values (%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@)", personImageName, coatName, coatName2, pantsName, skirtName, shoesName, bagName, accessoryName, imageDate, remarks, mood];
    if ([self.db executeUpdate:@"insert into PersonModel (personImageName, coatName, coatName2, pantsName, skirtName, shoesName, bagName, imageDate, remarks, mood) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", personImageName, coatName, coatName2, pantsName, skirtName, shoesName, bagName, imageDate, remarks, mood]) {
        NSLog(@"insert successed");
    }
}

#pragma mark 实现修改数据
//- (void)updateData
//{
//    if ([self.db executeUpdate:@"UPDATE Person set age = ? WHERE name = ?", [NSNumber numberWithInteger:100], @"Jone"]) {
//        NSLog(@"Updata Successed");
//    }
//}

#pragma mark 实现删除数据
- (void)deleteDataWithImageName:(NSString *)imageName
{
    if ([self.db executeUpdate:@"DELETE FROM Clothes WHERE imageName = ?", imageName]) {
        NSLog(@"Delete Successed");
    }
}

#pragma mark 实现查询全部数据
- (NSMutableArray *)searchData
{
    NSMutableArray *allImageArray = [NSMutableArray array];
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT imageName FROM Clothes"];
    while ([resultSet next]) {
        NSString *imageName = [resultSet stringForColumn:@"imageName"];
        [allImageArray addObject:imageName];
    }
    [resultSet close];
    return allImageArray;
}

#pragma mark 实现查询分类数据
- (NSMutableArray *)searchDataWithClassName:(NSString *)className
{
    NSMutableArray *classImageArray = [NSMutableArray array];
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT imageName FROM Clothes where className = ?", className];
    while ([resultSet next]) {
        NSString *imageName = [resultSet stringForColumn:@"imageName"];
        [classImageArray addObject:imageName];
    }
    [resultSet close];
    return classImageArray;
}

#pragma mark 实现查询子分类数据
- (NSMutableArray *)searchDataWithSubClassName:(NSString *)subClassName
{
    NSMutableArray *subClassImageArray = [NSMutableArray array];
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT imageName FROM Clothes where subClassName = ?", subClassName];
    while ([resultSet next]) {
        NSString *imageName = [resultSet stringForColumn:@"imageName"];
        [subClassImageArray addObject:imageName];
    }
    [resultSet close];
    return subClassImageArray;
}

#pragma mark 根据className查询所有子类名
- (NSMutableArray *)searchWithClassName:(NSString *)className
{
    NSMutableArray *subClassNameArray = [NSMutableArray array];
//    NSString *str = [NSString stringWithFormat:@"select * from SubClassification"];
    FMResultSet *resultSet = [self.db executeQuery:@"select subClassName from SubClassification where className = ?", className];
    while ([resultSet next]) {
        NSString *subClassName = [resultSet stringForColumn:@"subClassName"];
        [subClassNameArray addObject:subClassName];
    }
    [resultSet close];
    return subClassNameArray;
}

#pragma mark 查询imageName为指定值的数据的所有信息
- (WSClothingModel *)searchOneDataWithImageName:(NSString *)imageName
{
    WSClothingModel *clothingModel = [[WSClothingModel alloc] init];
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM Clothes WHERE imageName = ?", imageName];
    while ([resultSet next]) {
        clothingModel.imageName = [resultSet stringForColumn:@"imageName"];
        clothingModel.className = [resultSet stringForColumn:@"className"];
        clothingModel.subClassName = [resultSet stringForColumn:@"subClassName"];
        clothingModel.season = [resultSet stringForColumn:@"season"];
        clothingModel.brand = [resultSet stringForColumn:@"brand"];
        clothingModel.price = [resultSet stringForColumn:@"price"];
        clothingModel.date = [resultSet dateForColumn:@"date"];
        clothingModel.remarks = [resultSet stringForColumn:@"remarks"];
        clothingModel.color = [resultSet stringForColumn:@"color"];
    }
    [resultSet close];
    return [clothingModel autorelease];
}

#pragma mark 根据某个字段筛选出PersonModel 可能一个可能多个
- (id)searchFromPersonModel:(NSString *)name withValue:(NSString *)value
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM PersonModel WHERE %@ = ?", name];
    NSMutableSet *personModelSet = [NSMutableSet set];
    FMResultSet *resultSet = [self.db executeQuery:sql, value];
    while ([resultSet next]) {
        
        WSPersonModel *personModel = [[WSPersonModel alloc] init];
        personModel.personImageName = [resultSet stringForColumn:@"personImageName"];
        personModel.coatName = [resultSet stringForColumn:@"coatName"];
        personModel.coatName2 = [resultSet stringForColumn:@"coatName2"];
        personModel.pantsName = [resultSet objectForColumnName:@"pantsName"];
        personModel.skirtName = [resultSet stringForColumn:@"skirtName"];
        personModel.shoesName = [resultSet stringForColumn:@"shoesName"];
        personModel.bagName = [resultSet stringForColumn:@"bagName"];
        personModel.imageDate = [resultSet dateForColumn:@"imageDate"];
        personModel.remarks = [resultSet stringForColumn:@"remarks"];
        personModel.mood = [resultSet stringForColumn:@"mood"];
        
        [personModelSet addObject:personModel];
        
        [personModel release];
        
        if ([name isEqualToString:@"personImageName"]) {
            return personModel;
        }
        
    }
    [resultSet close];
    return personModelSet;
}

#pragma mark 根据personImageName查询出当前model身上所有衣物
- (NSMutableArray *)searchPersonClothWithPersonModel:(NSString *)personImageName
{
    NSMutableArray *clothArray = [NSMutableArray array];
    WSPersonModel *personModel = [self searchFromPersonModel:@"personImageName" withValue:personImageName];
    if (![personModel.coatName isEqualToString:@""]) {
        [clothArray addObject:personModel.coatName];
    }
    if (![personModel.coatName2 isEqualToString:@""]) {
        [clothArray addObject:personModel.coatName2];
    }
    if (![personModel.pantsName isEqualToString:@""]) {
        [clothArray addObject:personModel.pantsName];
    }
    if (![personModel.skirtName isEqualToString:@""]) {
        [clothArray addObject:personModel.skirtName];
    }
    if (![personModel.bagName isEqualToString:@""]) {
        [clothArray addObject:personModel.bagName];
    }
    return clothArray;
}

#pragma mark 根据试衣间里的数据查询出所有符合条件的PersonModel
- (NSMutableSet *)searchPersonModelWithDress:(NSMutableDictionary *)dressDict
{
    NSMutableArray *setArray = [NSMutableArray array];
    NSArray *array = [dressDict allKeys];
    for (NSString *key in array) {
        NSMutableSet *set = [self searchFromPersonModel:key withValue:dressDict[key]];
        [setArray addObject:set];
    }
    for (int i = 0; i < setArray.count; i ++) {
        if (i == setArray.count - 1) {
            break;
        }
        [setArray[i + 1] intersectsSet:setArray[i]];
    }
    return setArray.lastObject;
}

#pragma mark 查询所有clothing返回数组
- (NSMutableArray *)searchAllClothing
{
    NSMutableArray *clothingArray = [NSMutableArray array];
    NSMutableArray *nameArray = [self searchData];
    for (NSString *name in nameArray) {
        [clothingArray addObject:[self searchOneDataWithImageName:name]];
    }
    return clothingArray;
}


#pragma mark 按时间分组输出衣物分类
- (NSMutableDictionary *)groupedClothingByDate
{
    NSMutableArray *allClothing = [dataManager searchAllClothing];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (WSClothingModel *clothing in allClothing) {
        NSString *dateStr = [self calculatetTimeInMonthOrYear:clothing.date];
        if ([dictionary[dateStr] count] == 0) {
            NSMutableArray *array = [NSMutableArray arrayWithObject:clothing];
            [dictionary setObject:array forKey:dateStr];
        }else {
            [dictionary[dateStr] addObject:clothing];
            [self sortByDateWith:dictionary[dateStr]];
        }
    }
    return dictionary;
}

- (NSString *)calculatetTimeInMonthOrYear:(NSDate *)date
{
    
    NSInteger nowYear = [self getYearFromDate:[NSDate date]];
    NSInteger nowMonth = [self getMonthFromDate:[NSDate date]];
    NSInteger year = [self getYearFromDate:date];
    NSInteger month = [self getMonthFromDate:date];
    if (year == nowYear) {
        if (month == nowMonth) {
            return @"本月";
        }else {
            return [NSString stringWithFormat:@"%d月份", month];
        }
    }else {
        return [NSString stringWithFormat:@"%d年", year];
    }
    
    
    
    
}


#pragma mark 获得是几月
- (NSInteger)getMonthFromDate:(NSDate*)date

{
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents* components = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit |
    
    NSMonthCalendarUnit |
    
    NSDayCalendarUnit |
    
    NSWeekdayCalendarUnit |
    
    NSHourCalendarUnit |
    
    NSMinuteCalendarUnit |
    
    NSSecondCalendarUnit;
    
    
    
    components = [calendar components:unitFlags fromDate:date];
    
    //    NSUInteger weekday = [components weekday];
    NSInteger month = [components month];
    NSLog(@"%d月", month);
    return month;
    
}

#pragma mark 获得是哪一年
- (NSInteger)getYearFromDate:(NSDate*)date

{
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents* components = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit |
    
    NSMonthCalendarUnit |
    
    NSDayCalendarUnit |
    
    NSWeekdayCalendarUnit |
    
    NSHourCalendarUnit |
    
    NSMinuteCalendarUnit |
    
    NSSecondCalendarUnit;
    
    
    
    components = [calendar components:unitFlags fromDate:date];
    
    
    NSInteger year = [components year];
    NSLog(@"year%d", year);
    
    return year;
    
}

#pragma mark 按时间排序
- (void)sortByDateWith:(NSMutableArray *)clothArray
{
    NSComparator dateSort = ^(WSClothingModel *clothing1, WSClothingModel *clothing2) {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"YYYYMMdd"];
        return [[dateFormatter stringFromDate:clothing1.date] compare:[dateFormatter stringFromDate:clothing2.date]];
    };
    [clothArray sortedArrayUsingComparator:dateSort];
}

#pragma mark 按季节分组输出衣物分类
- (NSMutableDictionary *)groupedClothingBySeason
{
    NSMutableArray *allClothing = [dataManager searchAllClothing];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//    [dictionary setObject:[NSMutableArray array] forKey:@"春"];
//    [dictionary setObject:[NSMutableArray array] forKey:@"夏"];
//    [dictionary setObject:[NSMutableArray array] forKey:@"秋"];
//    [dictionary setObject:[NSMutableArray array] forKey:@"冬"];
//    [dictionary setObject:[NSMutableArray array] forKey:@"未标注季节"];
    
    for (WSClothingModel *clothing in allClothing) {
        NSMutableArray * seasonArray = [NSMutableArray array];
        for (int i = 0; i < clothing.season.length; i ++) {
            [seasonArray addObject:[clothing.season substringWithRange:NSMakeRange(i, 1)]];
        }
        if (seasonArray.count == 0) {
            if ([dictionary[@"未标注季节"] count] == 0) {
                NSMutableArray *array = [NSMutableArray arrayWithObject:clothing];
                [dictionary setObject:array forKey:@"未标注季节"];
            }else {
                [dictionary[@"未标注季节"] addObject:clothing];
                [self sortByDateWith:dictionary[@"未标注季节"]];
            }
        }else {
        for (NSString *seasonStr in seasonArray) {
            
//            if ([seasonStr isEqualToString:@"春"]) {
//                [dictionary[@"春"] addObject:clothing];
//                [self sortByDateWith:dictionary[@"春"]];
//            }else if ([seasonStr isEqualToString:@"夏"]) {
//                [dictionary[@"夏"] addObject:clothing];
//                [self sortByDateWith:dictionary[@"夏"]];
//            }else if ([seasonStr isEqualToString:@"秋"]) {
//                [dictionary[@"秋"] addObject:clothing];
//                [self sortByDateWith:dictionary[@"秋"]];
//            }else if ([seasonStr isEqualToString:@"冬"]) {
//                [dictionary[@"冬"] addObject:clothing];
//                [self sortByDateWith:dictionary[@"冬"]];
//            }else {
//                [dictionary[@"未标注季节"] addObject:clothing];
//                [self sortByDateWith:dictionary[@"未标注季节"]];
//            }
            
           
                if ([dictionary[seasonStr] count] == 0) {
                    NSMutableArray *array = [NSMutableArray arrayWithObject:clothing];
                    [dictionary setObject:array forKey:seasonStr];
                }else {
                    [dictionary[seasonStr] addObject:clothing];
                    [self sortByDateWith:dictionary[seasonStr]];
                }
            
            
        }
        }
        

        
        
    }
    return dictionary;
}

#pragma mark 按品牌分组输出衣物分类
- (NSMutableDictionary *)groupedClothingByBrand
{
    NSMutableArray *allClothing = [dataManager searchAllClothing];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    for (WSClothingModel *clothing in allClothing) {
        NSString *brandStr = clothing.brand;
        if (brandStr.length == 0) {
            if ([dictionary[@"未标注品牌"] count] == 0) {
                NSMutableArray *array = [NSMutableArray arrayWithObject:clothing];
                [dictionary setObject:array forKey:@"未标注品牌"];
            }else {
                [dictionary[@"未标注品牌"] addObject:clothing];
                [self sortByDateWith:dictionary[@"未标注品牌"]];
            }
        }else {
            if ([dictionary[brandStr] count] == 0) {
                NSMutableArray *array = [NSMutableArray arrayWithObject:clothing];
                [dictionary setObject:array forKey:brandStr];
            }else {
                [dictionary[brandStr] addObject:clothing];
                [self sortByDateWith:dictionary[brandStr]];
            }
        }
    }
    
    return dictionary;
}
#pragma mark 按价格分组输出衣物分类
- (NSMutableDictionary *)groupedClothingByPrice
{
    NSMutableArray *allClothing = [dataManager searchAllClothing];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    for (WSClothingModel *clothing in allClothing) {
        double price = 0.f;
        if (clothing.price.length != 0) {
            price = [clothing.price doubleValue];
        }
 
        NSLog(@"%f", price);
        if (price == 0.f) {
            if ([dictionary[@"未标注价格"] count] == 0) {
                NSMutableArray *array = [NSMutableArray arrayWithObject:clothing];
                [dictionary setObject:array forKey:@"未标注价格"];
            }else {
                [dictionary[@"未标注价格"] addObject:clothing];
                [self sortByDateWith:dictionary[@"未标注价格"]];
            }
        }else if (price < 100.f) {
            if ([dictionary[@"100元以下"] count] == 0) {
                NSMutableArray *array = [NSMutableArray arrayWithObject:clothing];
                [dictionary setObject:array forKey:@"100元以下"];
            }else {
                [dictionary[@"100元以下"] addObject:clothing];
                [self sortByDateWith:dictionary[@"100元以下"]];
            }
        }else if (price < 500.f) {
            if ([dictionary[@"100-499.9元"] count] == 0) {
                NSMutableArray *array = [NSMutableArray arrayWithObject:clothing];
                [dictionary setObject:array forKey:@"100-499.9元"];
            }else {
                
                [dictionary[@"100-499.9元"] addObject:clothing];
                [self sortByDateWith:dictionary[@"100-499.9元"]];
            }

        }else if (price < 1000.f) {
            if ([dictionary[@"500-999.9元"] count] == 0) {
                NSMutableArray *array = [NSMutableArray arrayWithObject:clothing];
                [dictionary setObject:array forKey:@"500-999.9元"];
            }else {
                
                [dictionary[@"500-999.9元"] addObject:clothing];
                [self sortByDateWith:dictionary[@"500-999.9元"]];
            }

        }else {
            if ([dictionary[@"1000元以上"] count] == 0) {
                NSMutableArray *array = [NSMutableArray arrayWithObject:clothing];
                [dictionary setObject:array forKey:@"1000元以上"];
            }else {
                [dictionary[@"1000元以上"] addObject:clothing];
                [self sortByDateWith:dictionary[@"1000元以上"]];
            }

        }
        
        
        
    }
    return dictionary;
}

#pragma mark 按颜色分组输出衣物分类
- (NSMutableDictionary *)groupedClothingByColor
{
    NSMutableArray *allClothing = [dataManager searchAllClothing];
    //    NSLog(@"clothing = %@", allClothing);
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    for (WSClothingModel *clothing in allClothing) {
        //        NSLog(@"color%@", clothing.color);
        NSMutableArray * colorArray = [NSMutableArray array];
        for (int i = 0; i < clothing.color.length; i ++) {
            [colorArray addObject:[clothing.color substringWithRange:NSMakeRange(i, 1)]];
            NSLog(@"%@", [clothing.color substringWithRange:NSMakeRange(i, 1)]);
        }
        if (colorArray.count == 0) {
            if ([dictionary[@"未标注颜色"] count] == 0) {
                NSMutableArray *array = [NSMutableArray arrayWithObject:clothing];
                [dictionary setObject:array forKey:@"未标注颜色"];
            }else {
                [dictionary[@"未标注颜色"] addObject:clothing];
                [self sortByDateWith:dictionary[@"未标注颜色"]];
            }
        }else {

            for (NSString *colorStr in colorArray) {
                if ([dictionary[colorStr] count] == 0) {
                    NSMutableArray *array = [NSMutableArray arrayWithObject:clothing];
                    [dictionary setObject:array forKey:colorStr];
                }else {
                    [dictionary[colorStr] addObject:clothing];
                    [self sortByDateWith:dictionary[colorStr]];
                }
            
        }
        }
        
        
    }
    return dictionary;
}

#pragma mark 根据字符输出颜色
- (UIColor *)getColorFromString:(NSString *)string
{
    
    NSArray *colorArray = @[[UIColor grayColor],[UIColor purpleColor],[UIColor colorWithRed:255/255.0 green:128/255.0 blue:128/255. alpha:1.],[UIColor blueColor],[UIColor greenColor],[UIColor blackColor],[UIColor cyanColor],[UIColor yellowColor],[UIColor whiteColor],[UIColor orangeColor]];
    if ([string isEqualToString:@"褐"]) {
        return colorArray[0];
    }else if ([string isEqualToString:@"紫"]) {
        return colorArray[1];
    }else if ([string isEqualToString:@"粉"]) {
        return colorArray[2];
    }else if ([string isEqualToString:@"蓝"]) {
        return colorArray[3];
    }else if ([string isEqualToString:@"绿"]) {
        return colorArray[4];
    }else if ([string isEqualToString:@"黑"]) {
        return colorArray[5];
    }else if ([string isEqualToString:@"青"]) {
        return colorArray[6];
    }else if ([string isEqualToString:@"黄"]) {
        return colorArray[7];
    }else if ([string isEqualToString:@"白"]) {
        return colorArray[8];
    }else  if ([string isEqualToString:@"橘"]) {
        return colorArray[9];
    }else {
        return [UIColor whiteColor];
    }
    
    
    
}
@end
