//
//  RecipesInfoViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-3-11.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "RecipesInfoViewController.h"
#import "UIUtils.h"
#import "UIImageView+WebCache.h"
#import "SamesczhulistModel.h"
#import "SamescfulistModel.h"
#import "KwviewrowModel.h"
#import "DiscoverViewController.h"

#import "MainViewController.h"
#define labelWidth 100


@implementation RecipesInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (int)getjisun:(int)count{
    
    int row = 1, cloum = 0;
    if(count > 3){
        
        
        for (int i=0; i < count; i++) {
            cloum++;
            if ((cloum % 3) == 0 && cloum < count) {
                row++;
            }
           
            
        }
        
    }
    return row * 50;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    
    _oneH = [self getjisun:_recipesModel.samesczhulist.count];
    _twoH = [self getjisun:_recipesModel.samescfulist.count];
    
    //cb_tese
    
    _cb_tese = [[RTLabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    _cb_tese.text = _recipesModel.cb_tese;
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
         [self.view addSubview:_tableView];
    }
    
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, 50 + _oneH + _twoH +400);
    
    _imageView = [[UIImageView alloc]init];
    float imageWidth = _recipesModel.cb_icon_width.floatValue;
    float imageHeight = _recipesModel.cb_icon_height.floatValue;
    
    float t_width = ScreenWidth - imageWidth;
    float t_height = imageHeight + t_width;
    _imageView.frame = CGRectMake(0, 0, ScreenWidth, t_height);
    _imageView.backgroundColor = [UIColor blackColor];
    NSString *strUrl =[NSString stringWithFormat:@"http://www.0773time.com/Public/uploads/food/cookbook/icon/%@%@",_recipesModel.cb_icon_u,_recipesModel.cb_icon];
    NSURL *ImageUrl = [NSURL URLWithString:strUrl];
    [_imageView setImageWithURL:ImageUrl placeholderImage:[UIImage imageNamed:@"RecipesIcon.png"]];
    
    [_tableView setTableHeaderView:_imageView];
   
    _tableView.tableHeaderView.height = t_height;
   
    
    [self _LoadData];
    
  
    
    NSString *str = [UIUtils getImage:_recipesModel.cb_bz_content];
   
   
    _webView = [[UIWebView alloc]init];
    _webView.frame = CGRectMake(0, 0, ScreenWidth,400);
     
    [_webView loadHTMLString:str baseURL:Nil];
     
    
    
  /*
    UITextView *textView = [[UITextView alloc] init];
    textView.textColor = [UIColor redColor];
    _textView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 400)];
    textView.scrollsToTop = NO;
   
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    [_textView addSubview:textView];
    [_textView addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-10-[textView]-5-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(textView)]];
    [_textView addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-5-[textView]-5-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(textView)]];
    
    NSString *htmlString = str;//_recipesModel.cb_content;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                   initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                   options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                   documentAttributes:nil
                                                   
                                                   error:nil];

    
    
    textView.attributedText  =   attributedString;
    
    textView.editable = NO;
    textView.directionalLockEnabled = YES;
    textView.bounces = NO;
    _tableView.bounces = NO;
     */
     [self.view addSubview:_backButton];
     
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
   
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark loaddata

- (void)_LoadData {
    
    
    
}



#pragma  mark rtLabel delegate

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url{
    DiscoverViewController *disVC = [[DiscoverViewController alloc]init];
    NSString *urlString = [url absoluteString];
    NSArray * array = [urlString componentsSeparatedByString:@"-"];
    if ([array[1] hasSuffix:@"sc_id"]) {
        disVC.sc_id = array[0];
    }
    else if ([array[1] hasSuffix:@"kw_id"]) {
        disVC.kw_id = array[0];
    }else if([array[1] hasSuffix:@"cat_id"]){
        disVC.cat_id = array[0];
    }
    
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:disVC animated:YES];
    [disVC release];
}


#pragma mark  UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellide = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellide];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellide]autorelease];
       
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        
        
        
        
        UIView *oneView = [[UIView alloc]init];
        oneView.frame = CGRectMake(0, 0, ScreenWidth, _oneH);
        oneView.backgroundColor = [UIColor redColor];
        UIView *twoView = [[UIView alloc]init];
        twoView.frame = CGRectMake(0, oneView.bottom, ScreenWidth, _twoH);
        
        UIView *threeView = [[UIView alloc]init];
        threeView.frame = CGRectMake(0, twoView.bottom, ScreenWidth, 50);
        threeView.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:oneView];
        [cell.contentView addSubview:twoView];
        [cell.contentView addSubview:threeView];
        [oneView release];
        [twoView release];
        [threeView release];
        
        if (_recipesModel.samesczhulist.count > 0) {
            int cloum = 0;
            int k = 0;
            
             for (int i = 0; i < _recipesModel.samesczhulist.count; i++) {
                RTLabel *samesczhulable = [[RTLabel alloc]initWithFrame:CGRectZero];
                 
               SamesczhulistModel *samesczhulist = [_recipesModel.samesczhulist objectAtIndex:i];
                NSString *str = [NSString stringWithFormat:@"<a href='%@-sc_id'>%@</a> : %@",samesczhulist.sc_id,samesczhulist.sc_name,samesczhulist.sc_num];
                samesczhulable.text = str;
                 
                 CGSize optimumSize = [samesczhulable optimumSize];
                 
                 
                 samesczhulable.frame = CGRectMake(cloum * labelWidth + 10, k * 40 + 10, optimumSize.width, 30);
                 samesczhulable.delegate = self;
                 cloum++;
                 if ( cloum % 3 == 0 && cloum < _recipesModel.samesczhulist.count) {
                     cloum = 0;
                     k++;
                 }

                 
                
                [oneView addSubview:samesczhulable];
                [samesczhulable release];
             
            }
            
            if (_recipesModel.samescfulist.count > 0) {
                int cloum = 0;
                int k = 0;
                for (int i = 0; i < _recipesModel.samescfulist.count; i++) {
                    RTLabel *samesczhulable = [[RTLabel alloc]initWithFrame:CGRectZero];
                    
                    
                    samesczhulable.delegate = self;
                   
                    SamescfulistModel *samesczhulist = [_recipesModel.samescfulist objectAtIndex:i];
                    NSString *str = [NSString stringWithFormat:@"<a href='%@-sc_id'>%@</a> : %@",samesczhulist.sc_id,samesczhulist.sc_name,samesczhulist.sc_num];
                    samesczhulable.text = str;
                    CGSize optimumSize = [samesczhulable optimumSize];
                    
                    
                    samesczhulable.frame = CGRectMake(cloum * labelWidth + 10, k * 40 + 10, optimumSize.width, 30);
                    cloum++;
                    if ( cloum % 3 == 0 && cloum < _recipesModel.samescfulist.count ) {
                        //                        samesczhulable.frame = CGRectMake(k * labelWidth+ 10, j * 40 + 10, labelWidth, 30);
                        cloum = 0;
                        k++;
                    }
                    
                   
                    
                    [twoView addSubview:samesczhulable];
                    [samesczhulable release];
                    
                }
            }
            
            if (_recipesModel.kwviewrow.count > 0) {
                for (int i = 0; i < _recipesModel.kwviewrow.count; i++) {
                    RTLabel *samesczhulable = [[RTLabel alloc]initWithFrame:CGRectZero];
                    samesczhulable.frame = CGRectMake(i * labelWidth + 10, 0 + 10, labelWidth, 30);
                    samesczhulable.delegate = self;
                    int j = 1;
                    if ( i % 3 == 0 && i != 0) {
                        samesczhulable.frame = CGRectMake(0+ 10, j * 40 + 10, labelWidth, 30);
                        j++;
                    }
                    KwviewrowModel *samesczhulist = [_recipesModel.kwviewrow objectAtIndex:i];
                    NSString *str = [NSString stringWithFormat:@"<a href='%@-kw_id'>%@</a>",samesczhulist.kw_id,samesczhulist.kw_name];
                    samesczhulable.text = str;
                    
                    [threeView addSubview:samesczhulable];
                    [samesczhulable release];
                    
                }
            }
            
            
                
            
            
        }
        
       
        
        
    }else if(indexPath.row == 1){
        _cb_tese.top = 5;
        _cb_tese.bottom = 5;
        _cb_tese.height = _cb_tese.optimumSize.height + 10;
        [cell.contentView addSubview:_cb_tese];
    }else if(indexPath.row == 2){
        
        [cell.contentView addSubview:_webView];
    }
    
    
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float h = 60;
    if (indexPath.row == 0) {
        
        
        
        h = 50 + _oneH + _twoH;
    }
    if (indexPath.row == 1) {
        h = _cb_tese.optimumSize.height;
    }
    
    if (indexPath.row == 2) {
//        h = _textView.height;;
        h = _webView.height;
    }
    
    
    return h;
}

- (IBAction)_backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)dealloc {
    [_backButton release];
    [_tableView release];
    [_imageView release];
    [_cb_tese release];
    [_textView release];
    [_webView release];
    [super dealloc];
}



@end
