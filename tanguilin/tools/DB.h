//
//  DB.h
//  tanguilin
//
//  Created by yangyuji on 14-3-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface DB : NSObject

//+ (id)shareDB;

//获得存放数据库文件的沙盒地址
+ (NSString *)databaseFilePath;

//创建数据库的操作

+(FMDatabase*)creatDatabase;

//创建表
+(BOOL)creatTable:(NSString*)tableName createSql:(NSString*)sql;

 
@end
