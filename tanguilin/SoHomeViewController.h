//
//  SoHomeViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-7-21.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//  有什么问题 请到 加入QQ群 170627662 ，提问，我会尽力回答大家的

#import <UIKit/UIKit.h>
typedef void(^SoTextBlock)(NSString* str);

@interface SoHomeViewController : UIViewController<UITextFieldDelegate>{
    UITextField *_soText;
}


@property (nonatomic,copy)SoTextBlock block;

@end
