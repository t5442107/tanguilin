//
//  LoginViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-28.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^loginBlock)(void);
@interface LoginViewController : UIViewController{
    
    IBOutlet UITextField *_username;
    IBOutlet UITextField *_password;
    IBOutlet UIButton *_back;
    IBOutlet UIButton *_loginButton;
    IBOutlet UIButton *regButton;
}

@property (nonatomic,copy)loginBlock block;

- (IBAction)backAction:(id)sender;
- (IBAction)loginAction:(id)sender;
- (IBAction)regAction:(id)sender;
@end
