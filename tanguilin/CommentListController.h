//
//  CommentListController.h
//  tanguilin
//
//  Created by yangyuji on 14-3-3.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"
#import "BaseTableView.h"
#import "MJRefresh.h"
#import "BaseViewController.h"
@interface CommentListController : BaseViewController<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>{
    
    IBOutlet BaseTableView *_tableView;
    NSMutableArray *_commentData;
    int  _p;
    NSMutableDictionary *_params;
    UIView *_replyView;
}

@property (nonatomic,retain)ShopModel *shopModel;

@end
