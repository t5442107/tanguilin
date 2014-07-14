//
//  BaseViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-21.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "tanguilinAppDelegate.h"
@interface BaseViewController : UIViewController {
    
}

@property (nonatomic,assign)BOOL isLoginButton;
@property (nonatomic,assign)BOOL isUserImage;
@property (nonatomic,assign)BOOL loginOK;
@property (nonatomic,copy)NSNumber *uid;

- (void)removeLoginButton;

- (tanguilinAppDelegate*)appDelegate;
@end
