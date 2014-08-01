//
//  tanguilinAppDelegate.m
//  tanguilin
//
//  Created by yangyuji on 14-2-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "tanguilinAppDelegate.h"
#import "MainViewController.h"
#import "LoginShare.h"
#import "JSONHTTPClient.h"
#import "LeftViewController.h"
#import "RightViewController.h"

#import <ShareSDK/ShareSDK.h>
#import "WeiboApi.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"


@implementation tanguilinAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [ShareSDK registerApp:@"18831adc05a2"];
    
    [self addShareSDK];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
//    self.window.backgroundColor = [UIColor whiteColor];
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"eNT29xKdnlI5ybifLLnFSOEF"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }else{
        NSLog(@"ok");
    }
    
    [self _checkVersion];
    
    //验证会员
    [self checkUser];
//
    
    [self.window makeKeyAndVisible];
    MainViewController *mainVC = [[MainViewController alloc]init];
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[SliderViewController sharedSliderController]];
    
    
    _ddmenu = [[DDMenuController alloc]init];
    _ddmenu.rootViewController = mainVC;
    RightViewController *rightVC = [[RightViewController alloc]init];
    LeftViewController *leftVC = [[LeftViewController alloc]init];
   
    
    _ddmenu.rightViewController = [rightVC autorelease] ;
    _ddmenu.leftViewController =   [leftVC autorelease];
    
    
    UINavigationController *rddmenu = [[UINavigationController alloc]initWithRootViewController:_ddmenu];
    _ddmenu.navigationController.navigationBarHidden = YES;
    
    self.window.rootViewController = rddmenu;
    [rddmenu release];
//    
//    [leftVC release];
//    [rightVC release];
    
    return YES;
}

- (void)_checkVersion{
    
    
    if (WXHLOSVersion() < 7) {
        NSLog(@"要7.0以上版本");
    }
}

- (void)checkUser{
    
    NSUserDefaults * tanguilin = [NSUserDefaults standardUserDefaults];
    NSNumber * uid = [tanguilin valueForKey:@"uid"];
    NSString *identifier = [tanguilin objectForKey:@"identifier"];
    if (uid.intValue > 0 || uid != nil) {
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:identifier,@"identifier", nil];
        
        [JSONHTTPClient postJSONFromURLWithString:CheckUserLogin params:params completion:^(id json, JSONModelError *err) {
            
            NSNumber *newuid           = (NSNumber*)[json objectForKey:@"uid"];
            NSNumber * status       = (NSNumber *)[json objectForKey:@"status"];
//            NSString *msg           = [json objectForKey:@"msg"];
            NSString *username      = [json objectForKey:@"username"];
            NSString *identifier    = [json objectForKey:@"identifier"];
            NSString *outTime       = [json objectForKey:@"outTime"];
            
            if ([status intValue] == 1) {
                
                NSUserDefaults * tanguilin = [NSUserDefaults standardUserDefaults];
                [tanguilin setInteger:[newuid integerValue] forKey:@"uid"];
                [tanguilin setObject:username forKey:@"username"];
                [tanguilin setObject:identifier forKey:@"identifier"];
                [tanguilin setObject:outTime forKey:@"outTime"];
                
                LoginShare *loginShare = [LoginShare shareLogin];
                loginShare.uid          = newuid;
                loginShare.username     = username;
                loginShare.identifier   = identifier;
                NSLog(@"appdele - uid = ---- %@",loginShare.uid);
                NSLog(@"appdele 登陆成功");
            }else{
                [[LoginShare shareLogin] removeUid];
                //通知  发送通知 改用户登陆 状态
                [[NSNotificationCenter defaultCenter] postNotificationName:loginStatusRemoveNotificationCenter object:nil];
                NSLog(@"appdele 删除成功");
            }
            
        }]; 
        
        
    }
    

    
}

//添加 shareSDK

- (void)addShareSDK{
    
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectSinaWeiboWithAppKey:@"3670759868"
                               appSecret:@"05f4426e101fee5c05a719fadb28c4a8"
                             redirectUri:@"https://api.weibo.com/oauth2/default.html"];
    
    /**
     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
     **/
    [ShareSDK connectTencentWeiboWithAppKey:@"801496720"
                                  appSecret:@"49e4e0e2e8c21efe29b95ea8405b2761"
                                redirectUri:@"http://www.0773time.com"
                                   wbApiCls:[WeiboApi class]];
    
    /**
     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
     **/
    [ShareSDK connectQZoneWithAppKey:@"101059359"
                           appSecret:@"6ea34f1b55cb66346e50b742c0da1ca1"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    [ShareSDK connectWeChatWithAppId:@"wx923e1ec879564f6c" wechatCls:[WXApi class]];
    
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
    //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
    //    [ShareSDK connectQQWithAppId:@"QQ075BCD15" qqApiCls:[QQApi class]];
    
    [ShareSDK connectQQWithQZoneAppKey:@"101059359"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    

    
}

- (BOOL)application:(UIApplication *)application  handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
