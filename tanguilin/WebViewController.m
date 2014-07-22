//
//  WebViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-2-26.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//  有什么问题 请到 加入QQ群 170627662 ，提问，我会尽力回答大家的

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

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
    if (_webView == nil) {
        _webView = [[UIWebView alloc]init];
    }
    _webView .frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webView release];
    [backButton release];
    [qianjingButton release];
    [shouxingButton release];
    [super dealloc];
}
- (IBAction)backAction:(id)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}

- (IBAction)qqianjingAction:(id)sender {
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}

- (IBAction)shouxingButton:(id)sender {
    [_webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
}

 
@end
