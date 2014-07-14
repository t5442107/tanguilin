//
//  ShopListAVViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-25.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopListAVViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
}

@property (nonatomic,retain)NSArray *data;
@end
