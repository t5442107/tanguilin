//
//  MyRecipesViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-4-8.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "BaseTableView.h"
@interface MyRecipesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
        BaseTableView *_tableView;
    int _page;
    int _pageCount;
    NSNumber *_totalCount;  //
}

@property(nonatomic,retain)NSMutableArray *data;
 

@end
