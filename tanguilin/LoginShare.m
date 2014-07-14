//
//  LoginShare.m
//  tanguilin
//
//  Created by yangyuji on 14-2-27.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "LoginShare.h"
#import "LoginViewController.h"
static LoginShare * loginshare = nil;

@implementation LoginShare


+ (id)shareLogin {
    
    @synchronized(self){
        
        if (loginshare == nil) {
            loginshare = [[[self class] alloc]init];
            
        }
        
    }
     
  
    
    return loginshare;
    
}

//会员登陆
- (void)addLoginUser:(id)who{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [who presentViewController:loginVC animated:YES completion:nil];
    [loginVC release];
}


- (NSNumber*)getUid{
    NSUserDefaults *tanguilin = [NSUserDefaults standardUserDefaults];
    NSNumber *uid =  [tanguilin objectForKey:@"uid"];
    self.uid = uid;
    return uid;
    
}
- (NSString *)getUsername{
    NSUserDefaults *tanguilin = [NSUserDefaults standardUserDefaults];
    self.username = [tanguilin objectForKey:@"username"];
    return [tanguilin objectForKey:@"username"];
}
- (NSString *)getIdentifier{
    NSUserDefaults *tanguilin = [NSUserDefaults standardUserDefaults];
    return [tanguilin objectForKey:@"identifier"];
}

- (void)removeUid{
    NSUserDefaults *tanguilin = [NSUserDefaults standardUserDefaults];
    [tanguilin removeObjectForKey:@"uid"];
    [tanguilin removeObjectForKey:@"username"];
    [tanguilin removeObjectForKey:@"identifier"];
     
}
 



+ (id)allocWithZone:(struct _NSZone *)zone{
    if (loginshare == nil) {
        loginshare = [super allocWithZone:zone];
    }
    return loginshare;
}

- (id)copyWithZone:(NSZone *)zone{
    return loginshare;
}

- (id)retain{
    return loginshare;
}

- (oneway void)release{
    
}

- (id)autorelease{
    return loginshare;
}

- (NSUInteger)retainCount{
    return UINT_MAX;
}









@end
