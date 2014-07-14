//
//  ProfileViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"
#import "MJRefresh.h"
#import "TgModel.h"
#import "BaseViewController.h"
@interface ProfileViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    BaseTableView *_tableView;
    NSMutableArray *_data;
    int _page;
    int _lastPosition;
}

@property(nonatomic,retain)TgModel *tgModel;

@end
