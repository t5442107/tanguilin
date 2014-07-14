//
//  LoginShare.h
//  tanguilin
//
//  Created by yangyuji on 14-2-27.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginShare : NSObject <NSCopying>


+ (id)shareLogin;

@property (nonatomic,copy)NSString *username;
@property (nonatomic,retain)NSNumber *uid;
@property (nonatomic,copy)NSString *identifier; 
@property (nonatomic,copy)NSString *outTime;
 
- (NSNumber*)getUid;
- (NSString *)getUsername;
- (NSString *)getIdentifier;
- (void)removeUid;
- (void)addLoginUser:(id)who;

@end
