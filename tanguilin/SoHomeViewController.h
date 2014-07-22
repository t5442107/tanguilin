//
//  SoHomeViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-7-21.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SoTextBlock)(NSString* str);

@interface SoHomeViewController : UIViewController<UITextFieldDelegate>{
    UITextField *_soText;
}


@property (nonatomic,copy)SoTextBlock block;

@end
