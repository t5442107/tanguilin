//
//  RegisterViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-4-13.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIAlertViewDelegate>
{
    
    IBOutlet UITextField *_usernameField;
   
    IBOutlet UITextField *_passwordField;
    
    IBOutlet UITextField *_password_reregField;
    
    IBOutlet UITextField *_emailField;
}

- (IBAction)_back:(id)sender;
- (IBAction)_regGo:(id)sender;
@end
