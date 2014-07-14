//
//  ProfileViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-2-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "ProfileViewController.h"
#import "LoginShare.h"
#import "JSONHTTPClient.h"
#import "TgtCell.h"
#import "TgtInfoViewController.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isLoginButton = NO;

    if (_data == nil) {
        _data = [[NSMutableArray alloc]init];
    }
    [self _initView];
}

- (void)_initView{
    self.title = @"美食日志";
    
    _lastPosition = 0;
    
    //
    _page = 2;
    
    if (_tableView == Nil) {
        _tableView = [[BaseTableView alloc]init];
        
        _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        [_tableView.header setHidden:NO];
    }
 
    [self.view addSubview:_tableView];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getData:[NSNumber numberWithInt:1] talbeView:nil];
    
    [self up];
    
    [self down];
    
    //header
    UIImageView *lcImageHeader = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 162)];
    lcImageHeader.image = [UIImage imageNamed:@"lc.png"];
    lcImageHeader.backgroundColor = [UIColor blackColor];
    [_tableView setTableHeaderView:lcImageHeader];
    [lcImageHeader release];
}

#pragma mark 调用http 取得数据

- (void)getData:(NSNumber*)page talbeView:(MJRefreshBaseView*)tableView{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:page,@"p", nil];
    [JSONHTTPClient getJSONFromURLWithString:GetTgUrl params:dic completion:^(id json, JSONModelError *err) {
        [self getDataFinish:json talbeView:tableView];
    }];
    
}

- (void)getDataFinish:(NSArray *)json talbeView:(MJRefreshBaseView*)tableView{
    
    if (json.count >= 19) {
        [_tableView.footer setHidden:NO];
    }else{
        [_tableView.footer setHidden:YES];
    }

    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:json.count];
    for (NSDictionary *dic in json) {
        TgModel *tgmodel = [[TgModel alloc]initWithDictionary:dic error:Nil];
        [array addObject:tgmodel];
        [tgmodel release];
    }
    
    if ([tableView isKindOfClass:[MJRefreshHeaderView class]]) {
        [_data removeAllObjects];
        [tableView endRefreshing];
    }
    
    [_data addObjectsFromArray:array];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_tableView reloadData];
    
    if ([tableView isKindOfClass:[MJRefreshFooterView class]]) {
        
        [tableView endRefreshing];
    }
}



#pragma mark UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifierCell = @"tgtCell";
    
    TgtCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TgtCell" owner:self options:nil]lastObject];
        //设置选中cell 的背景颜色
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0.0 alpha:0.05];
        cell.selectedBackgroundView = view;
        [view release];
        
    
    }
    
    TgModel *tgModel = [_data objectAtIndex:indexPath.row];
    
    cell.tgModel =tgModel;
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.00000000;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TgModel *tgModel = [_data objectAtIndex:indexPath.row];
    
    TgtInfoViewController *tgtInfoVC = [[TgtInfoViewController alloc]init];
    tgtInfoVC.tgModel = tgModel;
    [self.navigationController pushViewController:tgtInfoVC animated:YES];
    [tgtInfoVC release];
    
}

#pragma mark 上拉下接 

- (void)up{
    
    _tableView.header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self getData:[NSNumber numberWithInt:1] talbeView:refreshView];
    };
    
    _tableView.header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView){
      
        _page = 2;
    };
    
}

- (void)down{
    
    
         _tableView.footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
               [MBProgressHUD showHUDAddedTo:self.view animated:YES];
             [self getData:[NSNumber numberWithInt:_page] talbeView:refreshView];
         };
        
        _tableView.footer.endStateChangeBlock = ^(MJRefreshBaseView *refreshView){
           
            _page++;
        };
   
    
}

 

- (void)dealloc
{
    [super dealloc];
    [_tableView release];
    [_data release];
}

@end
