//
//  UIUtils.h
 

#import <Foundation/Foundation.h>
//#import "CONSTS.h"

@interface UIUtils : NSObject

//获取documents下的文件路径
+ (NSString *)getDocumentsPath:(NSString *)fileName;
// date 格式化为 string
+ (NSString*) stringFromFomate:(NSDate*)date formate:(NSString*)formate;
// string 格式化为 date
+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate;

+ (NSString *)fomateString:(NSString *)datestring;


+ (NSString *)getText:(NSString*)str;

+ (NSString *)getImage:(NSString*)str;

+ (NSString*)getUrlname:(NSString*)str; // 返回 rturl 中文编码
@end
