//
//  DiscoverViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"
#import "BaseViewController.h"
#import "RTLabel.h"
@interface DiscoverViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,RTLabelDelegate>{
    
    
    IBOutlet BaseTableView *_tableVIew;
//    NSMutableArray *_data;
    UIView *_menuView;
    
    NSArray * _sclistData;
    NSArray * _categorielistData;
    NSArray * _kwlistData;
    
    RTLabel *_kwlistLabel;  //口味
    RTLabel *_sclistLabel;  //食材
    RTLabel *_categorielistLabel; //类别
    
    NSString *_keyword;
    NSNumber *_totalCount;  //
    
    UIView *_view1;
    BOOL _isView1;
    UIView *_view2;
    BOOL _isView2;
    UIScrollView *_view3;
    BOOL _isView3;
    
    int _page;
}

@property(nonatomic,retain) NSNumber *sc_id;
@property(nonatomic,retain) NSNumber *kw_id;
@property(nonatomic,retain) NSNumber *cat_id;
@property(nonatomic,retain)NSMutableArray *data;

- (void)reTableView; //刷新tableView
@end
