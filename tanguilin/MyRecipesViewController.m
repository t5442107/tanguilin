//  我的菜普收藏
//  MyRecipesViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-4-8.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "MyRecipesViewController.h"
#import "RecipesModel.h"
#import "JSONHTTPClient.h"
#import "LoginShare.h"
#import "RecipesCell.h"
#import "RecipesInfoViewController.h"
@interface MyRecipesViewController ()

@end

@implementation MyRecipesViewController

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
    // Do any additional setup after loading the view.
    
    [self _initView];
}


- (void)_initView{
    self.title = @"我的收藏菜普";
    self.navigationController.navigationBarHidden = NO;
    _page = 2; //初始化 分页数
    _pageCount = 1;
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 50, 44);
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(blackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barLeft = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = barLeft;
    
        _tableView = [[BaseTableView alloc]init];
        _tableView.frame = CGRectMake(0, 0, ScreenWidth,  ScreenHeight);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    _data = [[NSMutableArray alloc]init]; 
    [self _initJson:1 tableView:nil];
    [self up];
    [self down];
}

#pragma mark - data
- (void)_initJson:(int)page tableView:(MJRefreshBaseView*)tableView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    LoginShare *login = [LoginShare shareLogin];
    
     NSMutableDictionary *params = [NSMutableDictionary dictionary]; 
    
    if (page > 1) {
        [params setObject:[NSNumber numberWithInt:page] forKey:@"p"];
    }
    
    [params setObject:login.identifier  forKey:@"identifier"];
    
    
    [JSONHTTPClient postJSONFromURLWithString:RecipesMyUrl params:params completion:^(id json, JSONModelError *err) {
        
        [self loadJsonData:json tableView:tableView];
        
    }];
}

- (void)loadJsonData:(NSDictionary *)json tableView:(MJRefreshBaseView*)tableView
{
    NSArray *array1 = [json objectForKey:@"diarylist"];
    NSNumber* isok = [json objectForKey:@"ok"];
     _totalCount = [json objectForKey:@"totalCount"];
    
    
    
    if (_totalCount.floatValue / 10 >  _pageCount) {
        [_tableView.footer setHidden:NO];
    }else{
        [_tableView.footer setHidden:YES];
    }
    
    
    
    if ( isok.intValue == 1)
    {
       
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:array1.count];
        
        for (int i = 0; i < array1.count; i++) {
            NSDictionary *dic = [array1 objectAtIndex:i];
            RecipesModel *recipesModel = [[RecipesModel alloc]initWithDictionary:dic error:nil];
            [array addObject:recipesModel];
            [recipesModel release];
        }
        
        if ([tableView isKindOfClass:[MJRefreshHeaderView class]]) {
            [tableView endRefreshing];
             [_data removeAllObjects];
        }
        
       
         
        [_data addObjectsFromArray:array];
        
        [_tableView reloadData];
        
        if ([tableView isKindOfClass:[MJRefreshFooterView class]]) {
            [tableView endRefreshing];
        }
        
    }else{
        [_tableView.footer setHidden:YES];
    }
   [MBProgressHUD hideHUDForView:self.view animated:YES];
}


#pragma mark button Action

- (void)blackButton{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -  UITableView delegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"RecipesCell";
    RecipesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RecipesCell" owner:self options:nil]lastObject];
        
        //设置选中cell 的背景颜色
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0.0 alpha:0.05];
        cell.selectedBackgroundView = view;
        [view release];
        
    }
    
    RecipesModel *recipesModel = [_data objectAtIndex:indexPath.row];
    cell.recipesModel = recipesModel;
    return cell;
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecipesModel *recipesModel = [_data objectAtIndex:indexPath.row];
    float he = [RecipesCell getCellHeight:recipesModel tableview:tableView];
    return he;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipesModel *recipesModel = [_data objectAtIndex:indexPath.row];
    RecipesInfoViewController *recipesInfoVC = [[RecipesInfoViewController alloc]init];
    recipesInfoVC.recipesModel = recipesModel;
    [self.navigationController pushViewController:recipesInfoVC animated:YES];
    [recipesInfoVC release];
}


#pragma mark 上下拉

- (void)up{
    
    _tableView.header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        _pageCount = 1;
        
        [self _initJson:1 tableView:refreshView]; //type = 2 是 下拉
    };
    
    _tableView.header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView){
        
        _page = 2;
    };
    
}



- (void)down{
    
    
    _tableView.footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        _pageCount ++;
        [self _initJson:_page tableView:refreshView]; //type = 2 是 下拉
        
    };
    
    _tableView.footer.endStateChangeBlock = ^(MJRefreshBaseView *refreshView){
        
        _page++;
    };
    
    
}



#pragma mark dealloc
- (void)dealloc
{
    
    [super dealloc];
    [_data release];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
