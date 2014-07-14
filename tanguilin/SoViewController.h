//
//  SoViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-3-16.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SoTextBlock)(NSString* str);

@interface SoViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource> {
    UITextField *_soText;
    UITableView *_tableView;
    NSMutableArray *_data;
}

@property (nonatomic,copy)SoTextBlock block;
@end
