//
//  UIUtils.m
 

#import "UIUtils.h"
#import <CommonCrypto/CommonDigest.h>
//#import "RegexKitLite.h"
#import "RegexKitLite.h"
//#import <RegexKit/RegexKit.h>
#import "NSString+URLEncoding.h"
@implementation UIUtils


+ (NSString *)getDocumentsPath:(NSString *)fileName {
    
    //两种获取document路径的方式
//    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [paths objectAtIndex:0];
    NSString *path = [documents stringByAppendingPathComponent:fileName];
    
    return path;
}

+ (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formate];
	NSString *str = [formatter stringFromDate:date];
	[formatter release];
	return str;
}

+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
NSDate *date = [formatter dateFromString:datestring];
    
    [formatter release];
    return date;
}

//Sat Jan 12 11:50:16 +0800 2013
+ (NSString *)fomateString:(NSString *)datestring {
    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSDate *createDate = [UIUtils dateFromFomate:datestring formate:formate];
    NSString *text = [UIUtils stringFromFomate:createDate formate:@"MM-dd HH:mm"];
    return text;
}

+ (NSString *)getText:(NSString*)str{
    
    
    NSString *reg = @"<br />";
    NSString *rep = @"\n";
    str = [str stringByReplacingOccurrencesOfString:reg withString:rep];
    
    return str;
}

+ (NSString *)getImage:(NSString*)text{
    // <img src="/public/uploads/food/foreteste/tgarticle/contentpic/t_1317368469.jpg" alt="" /><br /></span></p>
    NSString *reg = @"(/public|/bbs).*?\"";
//    NSString *reg1 = @"<img alt=\"\" src=\"";
//    NSString *rep2 = @"<img Width=300  src=\"http://www.0773time.com/";
    
     NSArray *array = [text componentsMatchedByRegex:reg];
    
    for (NSString *s in array) {
        NSString *stt = [NSString stringWithFormat:@"http://www.0773time.com%@ Width=\"300\" ",s];
       text = [text stringByReplacingOccurrencesOfString:s withString:stt];
        
         
    }
    
    return text;
    
}



 


@end
