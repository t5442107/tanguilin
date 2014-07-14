//
//  LoginViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-2-28.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "LoginViewController.h"
#import "JSONHTTPClient.h"
#import "BaseViewController.h"
#import "HomeViewController.h"
#import "LoginShare.h"

#import "RegisterViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _username.clearButtonMode = UITextFieldViewModeAlways;
    _password.clearButtonMode = UITextFieldViewModeAlways;
    
    [_username becomeFirstResponder];
    
    
    
    UIView * bView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight  )];
    bView.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"userbg.png"]];
    
    bView.alpha = 0.5;
    [self.view insertSubview:bView atIndex:0];
    [bView release];
    
    
    
}

 



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_username release];
    [_password release];
    [_back release];
    [_loginButton release];
    [regButton release];
    [super dealloc];
}
- (IBAction)backAction:(id)sender {
    
//
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    //
   
    
}

- (IBAction)loginAction:(id)sender {
    
    if (_username.text.length >0 && _password.text.length > 0) {
        NSString *url = UserLoginUrl;
        NSString *username = _username.text;
        NSString *password = _password.text;
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",password,@"password", nil];
        
        [JSONHTTPClient postJSONFromURLWithString:url params:params completion:^(id json, JSONModelError *err) {
            [self getLoginData:json];
        }];
    }
   
}

- (void)getLoginData:(NSDictionary*)json{
    
   
    
    if (json) {
        NSNumber *uid = (NSNumber*)[json objectForKey:@"uid"];
        NSNumber * status = (NSNumber *)[json objectForKey:@"status"];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *username = [json objectForKey:@"username"];
        NSString *identifier = [json objectForKey:@"identifier"];
        NSString *outTime = [json objectForKey:@"outTime"];
        
         NSLog(@"%@",msg);
        
        if ([status intValue] == 1) {
            
            NSUserDefaults * tanguilin = [NSUserDefaults standardUserDefaults];  
            [tanguilin setInteger:[uid integerValue] forKey:@"uid"];
            [tanguilin setObject:username forKey:@"username"];
            [tanguilin setObject:identifier forKey:@"identifier"];
            [tanguilin setObject:outTime forKey:@"outTime"];
            
            LoginShare *loginShare = [LoginShare shareLogin];
            loginShare.uid = uid;
            loginShare.identifier = identifier;
            loginShare.username = username;
            
//            if (self.block != nil ) {
//                _block();
//                
//                Block_release(_block);
//                _block = nil;
//            }
            
            //通知  发送通知 改用户登陆 状态
             [[NSNotificationCenter defaultCenter] postNotificationName:loginStatusNotificationCenter object:nil];
            [self backAction:self]; 
        }

    }
    
    
}

- (IBAction)regAction:(id)sender {
    RegisterViewController *regVC = [[RegisterViewController alloc]init];

    [self.navigationController pushViewController:regVC animated:YES];
    [regVC release];
    
}














@end
