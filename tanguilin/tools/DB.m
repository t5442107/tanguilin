//
//  DB.m
//  tanguilin
//
//  Created by yangyuji on 14-3-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "DB.h"
//static DB * Dbshare = nil;
@implementation DB

/*
+ (id)shareDB{
    
    @synchronized(self){
        
        if (Dbshare == nil) {
            Dbshare = [[[self class] alloc]init];
            
        }
    }
        return Dbshare;
}
*/
//打开和创建 数据库
+ (NSString *)databaseFilePath{
    
     NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    
    return path;
}

//创建数据库的操作

+(FMDatabase*)creatDatabase{
    
    NSString *path = [self databaseFilePath];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    return db;
    
}

//创建表
+(BOOL)creatTable:(NSString*)tableName createSql:(NSString*)sql{
    FMDatabase *db = [self creatDatabase];
    
    if (!db) {
        
        NSLog(@"创建数据库失败");
        return NO;
    }
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    
    //为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    //判断数据库中是否已经存在这个表，如果不存在则创建该表
    if (![db tableExists:tableName]) {
        [db executeUpdate:sql];
        NSLog(@"创建完成");
        
    }
    
     return YES;
}

 

/*

+ (id)allocWithZone:(struct _NSZone *)zone{
    if (Dbshare == nil) {
        Dbshare = [super allocWithZone:zone];
    }
    return Dbshare;
}

- (id)copyWithZone:(NSZone *)zone{
    return Dbshare;
}

- (id)retain{
    return Dbshare;
}

- (oneway void)release{
    
}

- (id)autorelease{
    return Dbshare;
}

- (NSUInteger)retainCount{
    return UINT_MAX;
}
*/
@end
