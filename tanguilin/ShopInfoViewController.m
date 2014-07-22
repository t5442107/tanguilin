//
//  ShopInfoViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-2-21.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//  有什么问题 请到 加入QQ群 170627662 ，提问，我会尽力回答大家的

#import "ShopInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "ShopMapViewController.h"
#import "RegexKitLite.h"
#import "LoginShare.h" 
#import "ShopInfoCommentCell.h"
#import "JSONHTTPClient.h"
#import "ShopInfoCommentModel.h"
#import "CommentListController.h" 

#import <ShareSDK/ShareSDK.h>

#import "ASIFormDataRequest.h"
@implementation ShopInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
   
         
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // _scrollView
    self.title = _shopMode.shop_name;
    
    
    //手势
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    [self.view addGestureRecognizer:swipe];
    [swipe release];
    
    
    
     _scrollView.frame  = CGRectMake(0,0, ScreenWidth, ScreenHeight);
    if (ScreenHeight > 480) {
        _scrollView.frame  = CGRectMake(0,-25-44-20, ScreenWidth, ScreenHeight);
    }
    //返回按扭
    _backButton.alpha = 0.5;
    _backButton.backgroundColor = [UIColor clearColor];     //_scrollView
    
    
    
    //大图
    _shop_image.frame = CGRectMake(0, 0, ScreenWidth, 190);
    NSString *imagUrl = [NSString stringWithFormat:@"http://www.0773time.com/Public/uploads/shop/icon/280_%@",_shopMode.shop_icon];
    [_shop_image setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:[UIImage imageNamed:@"imageP.png"]];
    _shop_image.contentMode = UIViewContentModeScaleAspectFit;
    _shop_image.userInteractionEnabled = YES;
    _shop_image.tag = (int)imagUrl;
    //给_shop_image添加点击
    UITapGestureRecognizer *imageTG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTG:)];
    
    [_shop_image addGestureRecognizer:imageTG];
    [imageTG release];
    //_titleView
    
    //标题
    _shop_name.text = _shopMode.shop_name;
    
    //联系电话
    _shop_tel.text = _shopMode.shop_phone;
    //人均消费
    _shop_cpc.text = _shopMode.shop_cpc;
    //地址
    _shop_address.text = _shopMode.shop_address;
    //服务
    _shop_paymentaddress.text = _shopMode.shop_paymentaddress;
    //标签
    _shop_frist_operate.text = _shopMode.shop_frist_operate;
    
    //foot
    _footView.frame = CGRectMake(0, ScreenHeight - 49, ScreenWidth, 49);
    
     //地图按扭//
    UIImage *image = [[UIImage imageNamed:@"button.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0];
     [_mapButton setBackgroundImage:image forState:UIControlStateNormal];
    _mapButton.backgroundColor = [UIColor whiteColor];
    [_mapButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
   
    
    //添加 评论 tableView
    
    
    if (_commentTableView == nil) {
        _commentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _titleView.bottom + 180, ScreenWidth, 100) style:UITableViewStylePlain];
        _commentTableView.delegate = self;
        _commentTableView.dataSource = self;
    }
    _commentTableView.scrollsToTop = NO;
    [_scrollView addSubview:_commentTableView];
    
   
    
    //加载评论
    NSNumber * limit = [NSNumber numberWithInt:1];
   
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInteger:_shopMode.shopid],@"shopid",limit,@"limit", nil];
    
    [JSONHTTPClient getJSONFromURLWithString:ShopInfoComment params:params completion:^(id json, JSONModelError *err) {
         [self getCommentData:json];
    }];
    
    
    
  
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

#pragma mark get Comment data 
- (void)getCommentData:(NSArray*)array{
    _commentData = array;
    [_commentData retain];
    [_commentTableView reloadData];
    
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _commentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ideCell = @"cell";
    
    ShopInfoCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ideCell];
    
    if (cell == nil) {
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"ShopInfoCommentCell" owner:self options:nil]lastObject]  ;
        
        
    }
    
    NSDictionary *dic = [_commentData objectAtIndex:indexPath.row];
    ShopInfoCommentModel *sicm = [[ShopInfoCommentModel alloc]initWithDictionary:dic error:nil];
    cell.shopInfoCommentModel = sicm;
    
    
    return cell;
    
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [_commentData objectAtIndex:indexPath.row];
    ShopInfoCommentModel *sicm = [[ShopInfoCommentModel alloc]initWithDictionary:dic error:nil];
    
    
    float height = [ShopInfoCommentCell getCellHeight:sicm tableview:tableView];

    
    _commentTableView.height = height;
    float scrollViewHeigh = _shop_image.height + _titleView.height + _infoView.height + _commentTableView.height ;
    
    _scrollView.contentSize = CGSizeMake(320, scrollViewHeigh);
    
    return height;
}

 

#pragma  mark Action
//评论按扭
- (IBAction)commonAction:(id)sender {
    //评论
    NSNumber * uid = [[LoginShare shareLogin] getUid];
    
    if (uid != nil || uid.intValue > 0) {
        
        
        
        _commentView = [[CommentView alloc]init];
        
        _commentView.backgroundColor = [UIColor clearColor];
        _commentView.layer.backgroundColor = [UIColor colorWithRed:0.373 green:0.373 blue:0.373 alpha:0.3].CGColor;
        
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removerComment:)];
        
        [_commentView addGestureRecognizer:tap];
        [tap release];
        [self.view addSubview:_commentView];
        [_commentView.commentTextView becomeFirstResponder];
        _commentView.frame = CGRectMake(0,ScreenHeight, ScreenWidth, ScreenHeight);
        
        [UIView animateWithDuration:0.3 animations:^{
            _commentView.transform = CGAffineTransformTranslate(_footView.transform, 0,  - ScreenHeight);
        }];
        
        _commentView.getBlock = ^(NSString *str,UIImage*image){
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            NSURL *url = [[NSURL alloc]initWithString:PostCommentUrl];
            
           
            
            if (str.length >0 || str != nil) {
                NSString *identifier =  [[LoginShare shareLogin] identifier];
                NSNumber *shopid = [NSNumber numberWithUnsignedInteger:_shopMode.shopid];
                
                NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:identifier,@"identifier",str,@"content",shopid,@"shopid", nil];
                if (image != NULL) {
                    [params setObject:image forKey:@"pic"];
                }
                
                ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
                request.delegate = self;
                request.requestMethod = @"POST";
                [request addData:imageData withFileName:[NSString stringWithFormat:@"%d.png",arc4random()] andContentType:@"image/png" forKey:@"pic"];
                [request addPostValue:identifier forKey:@"identifier"];
                [request addPostValue:shopid forKey:@"shopid"];
                [request addPostValue:str forKey:@"content"];
                
                [request startAsynchronous];
                
                //如果成功则自动执行
                
                [request setDidFinishSelector:@selector(requestedSuccessfully)];
                
                //如果失败则自动执行
                
                [request setDidFailSelector:@selector(requestedFail)];
                
                
                
                
                
//                [JSONHTTPClient postJSONFromURLWithString:PostCommentUrl params:params completion:^(id json, JSONModelError *err) {
//                    
//                    NSNumber* status = [json objectForKey:@"status"];
//                    
//                    if (status.intValue == 1) {
//                        
//                        [self reLoadTableData];
//                    }
//                    
//                }];
            }
            
            
            
            
        };
        
        
        
    }else{
        [[LoginShare shareLogin] addLoginUser:self];
    }
    
    
 

    
    
}

- (void)requestedSuccessfully
{
    [self reLoadTableData];
    NSLog(@"requestedSuccessfully");
}

- (void)requestedFail
{
    NSLog(@"requestedFail");
}

//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
    
}

//刷新评论

- (void)reLoadTableData {
    
    //加载评论
    NSNumber * limit = [NSNumber numberWithInt:1];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInteger:_shopMode.shopid],@"shopid",limit,@"limit", nil];
    
    [JSONHTTPClient getJSONFromURLWithString:ShopInfoComment params:params completion:^(id json, JSONModelError *err) {
        [self getCommentData:json];
        [_commentTableView reloadData];
    }];
    
    
    
}

//
- (IBAction)_commentListAction:(id)sender {
    CommentListController *commentTableVC = [[CommentListController alloc]init];
    commentTableVC.shopModel = _shopMode;
    [self.navigationController pushViewController:commentTableVC animated:YES];
    [commentTableVC release];
    
    
}

//分享

- (IBAction)_scAction:(id)sender {
    
    
    
    
    NSString *imagUrl = [NSString stringWithFormat:@"http://www.0773time.com/Public/uploads/shop/icon/280_%@",_shopMode.shop_icon];
    NSString *addUrl = [NSString stringWithFormat:@"http://www.0773time.com/food.php/Foodmap/viewmap/shopid/%d.html",_shopMode.shopid];
    
    /*
     [ShareSDK content:_shopMode.shop_name
                                       defaultContent:nil
                                                image:[ShareSDK imageWithUrl:imagUrl]
                                                title:_shopMode.shop_name
                                                  url:addUrl
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews
                                   locationCoordinate:nil
                                              groupId:nil];
    */
    id<ISSContent> publishContent = [ShareSDK content:_shopMode.shop_name
                                     
                                       defaultContent:@""
                                                image:[ShareSDK imageWithUrl:imagUrl]
                title:_shopMode.shop_name
                  url:addUrl
          description:nil
            mediaType:SSPublishContentMediaTypeNews];
    
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess) {
                                      NSLog(@"分享成功");
                                }else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                                
                            }];
    
}

- (void)removerComment:(UITapGestureRecognizer*)tap{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view resignFirstResponder];
        [_commentView.commentTextView resignFirstResponder];
        _commentView.transform = CGAffineTransformIdentity;
        
        
    } completion:^(BOOL finished) {
        [_commentView removeFromSuperview];
    }] ;
    
    
}


- (void)swipeAction:(UISwipeGestureRecognizer*)swipe{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
     
}

- (void)imageTG:(id)send{
    
    if (_mediaFocusController == nil) {
        _mediaFocusController = [[URBMediaFocusViewController alloc]init];
        
    } 
     NSString *imagUrl = [NSString stringWithFormat:@"http://www.0773time.com/Public/uploads/shop/icon/%@",_shopMode.shop_icon];
    [_mediaFocusController showImageFromURL:[NSURL URLWithString:imagUrl] fromView:_fullImageView];
    
    
     
    
   
}

 
- (IBAction)backAction:(UIButton*)sender {
    
    
    if (sender.tag == 106) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
        
    }else if(sender.tag == 103){
        
        ShopMapViewController *shopVC = [[ShopMapViewController alloc]init];
        shopVC.shopModel = _shopMode;
        [self.navigationController pushViewController:shopVC animated:YES];
        [shopVC release];
        
        
    }else if(sender.tag == 104){
        
        NSArray *tels = [_shopMode.shop_phone componentsMatchedByRegex:@"([\\d]*[-+—][\\d]*[-+—][\\d]*)|([\\d]*[-+—][\\d]*)|([\\d]+)"]; 
        if (_sheetView == nil) {
            _sheetView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, 320, 200)];

        }
        _sheetView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:_sheetView];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 320, 30)];
        label1.text = @"请点击你要拔打的电话号码?";
        label1.font = [UIFont boldSystemFontOfSize:16.f];
        label1.textColor = [UIColor whiteColor];
        [_sheetView addSubview:label1];
        [label1 release];
        
        for (int i = 0; i <tels.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:[tels objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            button.layer.borderWidth = 2;
            
            button.frame = CGRectMake((320 - 180)/2,label1.bottom + (40 *i)  , 180, 40);
            button.tag = i;
            [button addTarget:self action:@selector(telAction:) forControlEvents:UIControlEventTouchUpInside];
            [_sheetView addSubview:button];
        }
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 setTitle:@"取消" forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button2.layer.borderColor = [UIColor whiteColor].CGColor;
        button2.layer.borderWidth = 2;
        [button2 addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
        button2.frame = CGRectMake((320 - 180)/2, label1.bottom +(40 * tels.count) + 5 , 180, 40);
        button2.tag = 110;
        [_sheetView addSubview:button2];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _sheetView.transform = CGAffineTransformTranslate(_footView.transform, 0, -200);
        }];
        
        
    }else if(sender.tag == 105){
        
    }
}


- (void)telAction:(UIButton*)button{
    
     NSArray *tels = [_shopMode.shop_phone componentsMatchedByRegex:@"([\\d]*[-+—][\\d]*[-+—][\\d]*)|([\\d]*[-+—][\\d]*)|([\\d]+)"];
     int tag = button.tag;
    NSString *tel = [tels objectAtIndex:tag];
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    [callWebview release];
    [str release];
    
    [self callAction:button];
 
}
- (void)callAction:(UIButton *)button{
    
    
        [UIView animateWithDuration:0.3 animations:^{
            _sheetView.transform = CGAffineTransformIdentity;
        }];
    
    
}

 

- (void)dealloc
{
    
    NSLog(@"dealloc ShopInfoViewController");
    [_infoView release];
    [_commentList release];
    [super dealloc];
//    [_shopMode release];
    [_backButton release];
    [_scrollView release];
    [_shop_image release];
    [_titleView release];
    [_shop_name release];
    [_mapButton release];
    [_footView release];
    [_shop_tel release];
    [_shop_paymentaddress release];
    [_shop_frist_operate release];
    [_shop_cpc release];
    [_shop_address release];
    [_telButton release];
    [_scButton release];
    [_commonButton release];
    
    [_commentTableView release];
}



@end
