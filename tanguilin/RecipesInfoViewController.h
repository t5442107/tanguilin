//
//  RecipesInfoViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-3-11.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "BaseViewController.h"
#import "RecipesModel.h"
#import "RTLabel.h"
@interface RecipesInfoViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,RTLabelDelegate>{
    
    IBOutlet UIButton *_backButton;
    UITableView *_tableView;
    UIImageView *_imageView;
    float _oneH;
    float _twoH;
    RTLabel *_cb_tese;
    UIView *_textView;
    
    UIWebView *_webView;
}
- (IBAction)_backAction:(id)sender;

@property (nonatomic,retain)RecipesModel<Optional> *recipesModel;
@end
