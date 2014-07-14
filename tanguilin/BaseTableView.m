//
//  BaseTableView.m
//  tanguilin
//
//  Created by yangyuji on 14-2-18.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      
        [self _initView];
    }
    return self;
}
  
- (void)awakeFromNib{
    [self _initView];
}


- (void)_initView{
    self.isRefreshHeader = YES;
    self.isRefreshFoot = YES;
    
    if (self.isRefreshHeader) {
        self.header  = [MJRefreshHeaderView header];
        self.header.scrollView = self;
    }
    
    if (self.isRefreshFoot) {
        self.footer = [MJRefreshFooterView footer];
        self.footer.scrollView = self;
    }
    

 
    
    
    
}


- (void)dealloc
{
    [super dealloc];
    NSLog(@"BaseTableView dealloc");
    [_header release];
    [_footer release];
}


@end
