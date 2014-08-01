//
//  TgtInfoViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-3-6.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "TgtInfoViewController.h"
#import "NSString+HTML.h"
#import "UIUtils.h"
#import "LoginShare.h"
#import "JSONHTTPClient.h"
#import "UIImageView+WebCache.h"

#import <ShareSDK/ShareSDK.h>

@interface TgtInfoViewController ()
//创建js
- (NSString *)createJavaScript;
@end

@implementation TgtInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}





//创建js
- (NSString *)createJavaScript{
    NSString *js = @"var imgArray = document.getElementsByTagName('img');for(var i = 0; i < imgArray.length; i++){var img = imgArray[i];img.onclick=function(){var url='lfyprotocol:'+this.src;document.location = url;}}";
    return js;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"%@",webView);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _tgModel.art_title;
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 44);
    [rightButton setTitle:@"分享" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(feixianAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBBI = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBBI;
    
    [rightBBI release];
    
    
    _webView = [[UIWebView alloc]init];
    _webView.delegate = self;
    _webView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight + 49);
    
    _tgModel.art_content = [UIUtils getImage:_tgModel.art_content];
    [_webView loadHTMLString:_tgModel.art_content baseURL:Nil];
    
//    _webView.backgroundColor=[UIColor clearColor];
    
    for (UIView *aView in [_webView subviews])
        
    {
        
        if ([aView isKindOfClass:[UIScrollView class]])
            
        {
            
//            [(UIScrollView *)aView setShowsVerticalScrollIndicator:NO]; //右侧的滚动条 （水平的类似）
            
            [(UIScrollView *)aView setShowsHorizontalScrollIndicator:NO];
            
            for (UIView *shadowView in aView.subviews)
                
            {
                
                
                
                if ([shadowView isKindOfClass:[UIImageView class]])
                    
                { 
                    
                    shadowView.hidden = YES;  //上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                    
                } 
                
            } 
            
        } 
        
    }
    
    
   
    [self.view addSubview:_webView];
    
    /*
    NSString *str =  [UIUtils getImage:_tgModel.art_content];
    
    
    
    UITextView *textView = [[UITextView alloc] init];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    
    
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:textView];
     
    [textView release];
    
    [view addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|-5-[textView]-5-|"
                          options:0
                          metrics:nil
                          views:NSDictionaryOfVariableBindings(textView)]];
    [view addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|-5-[textView]-5-|"
                          options:0
                          metrics:nil
                          views:NSDictionaryOfVariableBindings(textView)]];
   
    
    NSString *htmlString = str;//_recipesModel.cb_content;
    
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                            options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes:nil
                                            error:nil];
    
    textView.attributedText = attributedString;
    
    textView.editable = NO;
    
    
    [self.view addSubview:view];
    [view release];
    */
    
//    
//    
//    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 10, ScreenWidth, 30)];
//    footer.backgroundColor = [UIColor whiteColor];
//    footer.tag = 2013;
//    [self.view addSubview:footer];
//    [footer release];
//    
//    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    commentButton.frame = CGRectMake(10,0, 80, 28);
//    [commentButton setTitle:@"说两句" forState:UIControlStateNormal];
//    [commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    commentButton.layer.borderWidth = 1;
//    commentButton.layer.borderColor = [UIColor blackColor].CGColor;
//    [commentButton addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
//    [footer addSubview:commentButton];
    
    
    
}

 

#pragma mark  webview delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"lfyprotocol"]) {
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"http"] || [(NSString *)[components objectAtIndex:1] isEqualToString:@"https"]){
            //这个就是图片的路径
            NSString *path = [NSString stringWithFormat:@"%@:%@",[components objectAtIndex:1],[components objectAtIndex:2]];
         
            if (_mediaFocusController == nil) {
                _mediaFocusController = [[URBMediaFocusViewController alloc]init];
                
            }
            
            [_mediaFocusController showImageFromURL:[NSURL URLWithString:path] fromView:_fullImageView];
            
            
            
        }
        return NO;
    }
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *str = [_webView stringByEvaluatingJavaScriptFromString:[self createJavaScript]];
    NSLog(@"------finish=%@",str);
}


- (void)commentAction:(UIButton*)but{
    
    
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
        
        UIView *footer = (UIView*)[self.view viewWithTag:2013];
        
        [UIView animateWithDuration:0.3 animations:^{
            _commentView.transform = CGAffineTransformTranslate(footer.transform, 0,  - ScreenHeight);
        }];
        
        _commentView.getBlock = ^(NSString *str,UIImage *image){
            
            
            if (str.length >0 || str != nil) {
                NSString *identifier =  [[LoginShare shareLogin] identifier];
                NSNumber *shopid =  _tgModel.tgart_id;
                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:identifier,@"identifier",str,@"content",shopid,@"shopid", nil];
                NSString *url = @"http://www.0773time.com/ios.php/shop/test";
                [JSONHTTPClient postJSONFromURLWithString:url params:params completion:^(id json, JSONModelError *err) {
                    
                    NSNumber* status = [json objectForKey:@"status"];
                    
                    NSLog(@"%@",json);
                    
                    if (status.intValue == 1) {
                        
                        
                    }
                    
                }];
            }
            
            
            
            
        };
        
        
        
    }else{
        [[LoginShare shareLogin] addLoginUser:self];
    }
    
    
    
    
    
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

- (void)feixianAction:(id)but
{
    
    
    NSString *imagUrl = [NSString stringWithFormat:@"http://www.0773time.com/Public/uploads/food/foreteste/tgarticle/covericon/200_%@",_tgModel.art_icon];
    NSString *addUrl = [NSString stringWithFormat:@"http://www.0773time.com/food.php/Foreteste/testecontent/tgart_id/%@.html",_tgModel.tgart_id];
    
   
    id<ISSContent> publishContent = [ShareSDK content:_tgModel.art_title
                                     
                                       defaultContent:@""
                                                image:[ShareSDK imageWithUrl:imagUrl]
                                                title:_tgModel.art_title
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_commentView release];
    [_webView release];
    [super dealloc];
}
@end
