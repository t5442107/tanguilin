//
//  HomeViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//  //  有问题需要解答的，让加q群 170627662 ,我会尽我全力来回答问题，谢谢支持！8446399

#import <UIKit/UIKit.h>
#import "BaseTableView.h"
#import "HdpIndexModel.h"
#import "ShopModel.h"
#import "BaseTableView.h"
#import "MJRefresh.h"
#import "MainViewController.h"
#import "BaseViewController.h"
#import "RegexKitLite.h"
@interface HomeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MJRefreshBaseViewDelegate ,UIScrollViewDelegate>{
    UIView *_headView;
    NSMutableArray * arrayM;
    UIPageControl *pageControl;
    UILabel *_noteTitle;
    MJRefreshFooterView *_foot;
    MJRefreshHeaderView *_header;
    NSUInteger _page;
    UIView *_menuBack;
    
    NSArray *_arrayGL;
    NSMutableDictionary *_params;
    MainViewController *_mainVC;
    
    int _lastPosition; //记录滑动旧记录
    
    UIView *_menu;
}
 

//@property (retain, nonatomic) IBOutlet BaseTableView *tableView; 
@property (retain, nonatomic) IBOutlet UITableView *tableView;

//@property (nonatomic,retain)HdpIndexModel *hdpModel;
@property (nonatomic,retain)NSMutableArray *hdpData;
@property (nonatomic,retain)UIScrollView *scrollView;

@property (nonatomic,retain)NSMutableArray *shops;

@end
