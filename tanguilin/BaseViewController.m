//
//  BaseViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-2-21.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import "LoginShare.h"
#import "UIButton+WebCache.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _isLoginButton = NO;
        _isUserImage = NO;
    //通知  接收通知 改用户登陆 状态
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeLoginButton) name:loginStatusNotificationCenter object:nil];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeLoginButton2) name:loginStatusRemoveNotificationCenter object:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSNumber * uid = [[LoginShare shareLogin] getUid];
    NSLog(@"uid=%@",uid);
	
    if (uid == nil || uid.intValue == 0) {
        if (_isLoginButton) {
            [self addLoginButton];
        }
        
    }else if(uid.intValue > 0 || uid != nil){
        if (_isUserImage) {
            [self addShowUser];
        }
        
        
    }
    
    
    [self.navigationItem setHidesBackButton:YES];
    
    NSLog(@"viewControllers = %d",self.navigationController.viewControllers.count);
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftActions)];
        [self.navigationItem setLeftBarButtonItem:leftButton];
    }
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.788 green:0.055 blue:0.090 alpha:1]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
     
    
    
    
    
    
}



- (tanguilinAppDelegate*)appDelegate {
    tanguilinAppDelegate *appDelegate = (tanguilinAppDelegate *)[UIApplication sharedApplication].delegate;
    
    return appDelegate;
}


#pragma mark Button Action
- (void)leftActions{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    /*
    [[LoginShare shareLogin] removeUid];
     [self.navigationItem setRightBarButtonItem:nil];
    [self addLoginButton];
     
     */
}

- (void)addLoginButton{
    //登陆按扭
    
//    UIBarButtonItem * loginButton = [[UIBarButtonItem alloc]initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(loginActions:)];
    
//    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"login"] style:UIBarButtonItemStylePlain target:self action:@selector(loginActions:)];
    
    UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(0, 3, 35, 35);
    [userButton setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [userButton setBackgroundImage:[UIImage imageNamed:@"login_h"] forState:UIControlStateHighlighted];
    [userButton addTarget:self action:@selector(loginActions:) forControlEvents:UIControlEventTouchUpInside]; 
    
    
    
    
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc]initWithCustomView:userButton];
    
    
    loginButton.tag = 2015;
    [self.navigationItem setRightBarButtonItem:loginButton];
    [loginButton release];
    
    

}


- (void)removeLoginButton{
        [self.navigationItem setRightBarButtonItem:nil];
        [self addShowUser];
    
}

- (void)removeLoginButton2{
    [self.navigationItem setRightBarButtonItem:nil];
    [self addLoginButton];
}



//加上登陆状态的
- (void)addShowUser{
    NSNumber *uid = [[LoginShare shareLogin] getUid];
     
    
    NSString *imgUrl = [NSString stringWithFormat:@"%@%d",UserFaceImage,uid.intValue];
    
    
    
    UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(0, 3, 35, 35);
//    [userButton setBackgroundImage:userface.image forState:UIControlStateNormal];
    [userButton setImageWithURL:[NSURL URLWithString:imgUrl]];
    [userButton addTarget:self action:@selector(tag:) forControlEvents:UIControlEventTouchUpInside];
    userButton.layer.masksToBounds = YES;
    userButton.layer.cornerRadius = 18.0;
    UIBarButtonItem *showUser = [[UIBarButtonItem alloc]initWithCustomView:userButton];
    
    
    [self.navigationItem setRightBarButtonItem:showUser];
    [showUser release];
    
    if (uid==nil) {
        NSLog(@"removeLoginButton");
//        [self performSelector:@selector(removeLoginButton) withObject:self afterDelay:1];
        
    }
    
}


- (void)tag:(UIButton *)but{
    
    [self.appDelegate.ddmenu showRightController:YES];
}
#pragma mark  Action
- (void)loginActions:(UIBarButtonItem *)but{
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
//    [self presentViewController:loginVC animated:YES completion:nil];
    [loginVC release];
    
//    loginVC.block = ^(void){
//        [self removeLoginButton];
//    };
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated]; 
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
    [_uid release];
    _uid = nil;
}

@end
