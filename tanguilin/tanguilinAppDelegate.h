//
//  tanguilinAppDelegate.h
//  tanguilin
//
//  Created by yangyuji on 14-2-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "BMapKit.h" 

#import "DDMenuController.h"
@interface tanguilinAppDelegate : UIResponder <UIApplicationDelegate>{
    BMKMapManager* _mapManager; 
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain)DDMenuController *ddmenu;

@end
