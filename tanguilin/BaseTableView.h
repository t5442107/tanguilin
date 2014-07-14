//
//  BaseTableView.h
//  tanguilin
//
//  Created by yangyuji on 14-2-18.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJRefresh.h"

@interface BaseTableView : UITableView

@property (nonatomic,retain) MJRefreshHeaderView *header;
@property (nonatomic,retain) MJRefreshFooterView *footer;
@property (nonatomic ,assign)BOOL isRefreshHeader;
@property (nonatomic ,assign)BOOL isRefreshFoot;

@end
