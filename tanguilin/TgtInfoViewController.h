//
//  TgtInfoViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-3-6.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "BaseViewController.h"
#import "TgModel.h"
#import "CommentView.h"
#import "URBMediaFocusViewController.h"

@interface TgtInfoViewController : BaseViewController<UIWebViewDelegate,URBMediaFocusViewControllerDelegate>{
     
    CommentView *_commentView;
     URBMediaFocusViewController *_mediaFocusController;  //放大图片类
    UIImageView *_fullImageView;
}


@property (nonatomic,retain)TgModel *tgModel;

@property (nonatomic, strong) UIWebView *webView;
@end
