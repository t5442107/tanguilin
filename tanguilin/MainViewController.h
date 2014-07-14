//
//  MainViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
////  有问题需要解答的，让加q群 170627662 ,我会尽我全力来回答问题，谢谢支持

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
