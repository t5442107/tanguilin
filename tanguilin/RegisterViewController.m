//
//  RegisterViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-4-13.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "RegisterViewController.h"
#import "JSONHTTPClient.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView * bView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight  )];
    bView.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"userbg.png"]];
    
    bView.alpha = 0.5;
    [self.view insertSubview:bView atIndex:0];
    [bView release];
    [_usernameField becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_usernameField release];
    [_passwordField release];
    [_password_reregField release];
    [_emailField release];
    [super dealloc];
}
- (IBAction)_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)_regGo:(id)sender {
    
    NSString *msg = @"";
    
    if (_usernameField.text == nil || _passwordField.text == NULL || _password_reregField.text == NULL || _emailField.text == NULL || [_usernameField.text isEqualToString:@""]||[_passwordField.text isEqualToString:@""]||[_password_reregField.text isEqualToString:@""]||[_emailField.text isEqualToString:@""]) {
        
          msg = @"都不能为空";
        
    }
     
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_usernameField.text,@"username",_passwordField.text,@"password",_password_reregField.text,@"password_rereg",_emailField.text,@"email", nil];
    
    [JSONHTTPClient postJSONFromURLWithString:RegisterIOSUrl params:params completion:^(id json, JSONModelError *err) {
        [self RegisterData:json];
    }];
    
    
    
}

- (void)RegisterData:(NSDictionary*)dic
{
    NSString *msg =  [dic objectForKey:@"msg"];
    [self showAlertView:msg];
    
  
}

- (void)showAlertView:(NSString *)str
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:str
                                                      delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self _back:nil];
}















@end
