//
//  MainViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h> 

#import "tanguilinAppDelegate.h"
@interface MainViewController : UITabBarController<UINavigationControllerDelegate> {
    
    UIImageView *_sideImageView;
//    UIView *_tabbarView;
    NSArray *_heightBackgroud;
    NSArray *_backgroud;
}

@property (nonatomic,retain)UIView *tabbarView;
- (void)showTabbar:(BOOL)show;



+ (void)showTabbars:(BOOL)show;

- (tanguilinAppDelegate*)appDelegate;
@end
