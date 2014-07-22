//
//  ShopInfoViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-21.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "BaseViewController.h"
#import "ShopModel.h"
#import "URBMediaFocusViewController.h"
#import "CommentView.h"


@interface ShopInfoViewController : BaseViewController<UIScrollViewDelegate,URBMediaFocusViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    IBOutlet UIScrollView *_scrollView;
    IBOutlet UIButton *_backButton;
    IBOutlet UIImageView *_shop_image;
    IBOutlet UIView *_titleView;
    IBOutlet UILabel *_shop_name;
    IBOutlet UIButton *_mapButton;
    IBOutlet UIView *_footView;
    
    IBOutlet UILabel *_shop_tel;
    
    IBOutlet UILabel *_shop_paymentaddress;
    IBOutlet UILabel *_shop_frist_operate;
    IBOutlet UILabel *_shop_cpc;
    IBOutlet UILabel *_shop_address;
    
    IBOutlet UIView *_infoView;
    IBOutlet UIButton *_telButton;
    
    IBOutlet UIButton *_scButton;
    UIView *_sheetView;
    UIImageView *_fullImageView;
   
    URBMediaFocusViewController *_mediaFocusController;  //放大图片类
    IBOutlet UIButton *_commonButton;
    CommentView *_commentView;
    
    UITableView *_commentTableView;
    NSArray *_commentData;
    IBOutlet UIButton *_commentList;
}

- (IBAction)backAction:(UIButton*)sender;
- (IBAction)commonAction:(id)sender;
- (IBAction)_commentListAction:(id)sender;
- (IBAction)_scAction:(id)sender;


@property (nonatomic,retain)ShopModel *shopMode;
 
@end
