//
//  WebViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-26.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//  有什么问题 请到 加入QQ群 170627662 ，提问，我会尽力回答大家的

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>{
    
    IBOutlet UIWebView *_webView;
    IBOutlet UIButton *backButton;
    IBOutlet UIButton *qianjingButton;
    IBOutlet UIButton *shouxingButton;
}

@property (nonatomic,copy)NSString*url;

- (IBAction)backAction:(id)sender;
- (IBAction)qqianjingAction:(id)sender;
- (IBAction)shouxingButton:(id)sender;
 

@end
