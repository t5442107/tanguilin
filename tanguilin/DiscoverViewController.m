//
//  DiscoverViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-2-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "DiscoverViewController.h"
#import "JSONHTTPClient.h"
#import "RecipesModel.h"
#import "RecipesCell.h"
#import "RecipesInfoViewController.h" 
#import "GTMDefines.h"
#import "NSString+URLEncoding.h"


#import "KwlistModel.h"
#import "SclistModel.h"
#import "CategorielistModel.h"

#import "SoViewController.h"

#import "MainViewController.h"
#import "LoginShare.h"
@implementation DiscoverViewController 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isLoginButton = YES;
        self.isUserImage = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad]; 
    self.title = @"美食课堂";
    _page = 2;
    _menuView = [[UIView alloc]initWithFrame:CGRectMake(0, 20+44, ScreenWidth, 25)];
    _menuView.backgroundColor = [UIColor whiteColor];
    
     
        //手势
        UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
        [self.view addGestureRecognizer:swipe];
        [swipe release];
          
     
    
    
    NSString *str1 = @"请选定口味";
    NSString *str2 = @"请选定类别";
    NSString *str3 = @"请选定食材";
    str1 = [str1 URLEncodedString];
    str2 = [str2 URLEncodedString];
    str3 = [str3 URLEncodedString];
    _kwlistLabel = [[RTLabel alloc]initWithFrame:CGRectMake(15, 5, 100, 25)];
    NSString *kwStr1 = [NSString stringWithFormat:@"<a href='%d-%d-%@'>%@</a>",1,1,str1,@"请选定口味"];
    _kwlistLabel.text = kwStr1;
    _kwlistLabel.delegate = self;
    
    _categorielistLabel = [[RTLabel alloc]initWithFrame:CGRectMake(_kwlistLabel.right + 10, 5, 100, 25)];
    NSString *kwStr2 = [NSString stringWithFormat:@"<a href='%d-%d-%@'>%@</a>",2,2,str2,@"请选定类别"];
    _categorielistLabel.text = kwStr2;
    _categorielistLabel.delegate = self;
    
    _sclistLabel = [[RTLabel alloc]initWithFrame:CGRectMake(_categorielistLabel.right  + 10, 5, 100, 25)];
     NSString *kwStr3 = [NSString stringWithFormat:@"<a href='%d-%d-%@'>%@</a>",3,3,str3,@"请选定食材"];
    _sclistLabel.text = kwStr3;
    _sclistLabel.delegate = self;
    [_menuView addSubview:_kwlistLabel];
    [_menuView addSubview:_categorielistLabel];
    [_menuView addSubview:_sclistLabel];
    
    //导航左边按扭
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 60, 44);
    [leftButton setTitle:@"搜索" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = barButton;
    
    
    
    
    
    
    [self _initJson];
    [self.view addSubview:_menuView];
    
    _tableVIew.frame = CGRectMake(0,25, ScreenWidth ,ScreenHeight -25 - 49 );
    
    [self _initJsonMenuData];
    
    
    //上拉下拉
    [self up];
    [self down];
    
    
}


#pragma mark 初始化分类
- (void)addViewcategory{
    
    if (_view1 == nil) {
        
        _view1 = [[UIView alloc]init];
        _view1.frame = CGRectMake(0, _menuView.bottom, ScreenWidth, ScreenHeight);
        _view1.backgroundColor = [UIColor colorWithRed:0.906 green:0.616 blue:0.467 alpha:0.8];
        
        [self.view addSubview:_view1];
        int cloum = 0 , row = 0;
        for (int i=0; i<_kwlistData.count; i++) {
            
            
            KwlistModel *kwlistModel = [[KwlistModel alloc]initWithDictionary:[_kwlistData objectAtIndex:i] error:Nil];
            
            RTLabel *klabel = [[RTLabel alloc]initWithFrame:CGRectMake(cloum * 100 + 20, row * 25 + 20, 100, 25)];
            klabel.delegate = self;
            NSString *kwStr1 = [NSString stringWithFormat:@"<a href='%d-%d-%@-%@'>%@</a>",4,[kwlistModel.kw_id intValue],[kwlistModel.kw_name URLEncodedString] ,@"kw_id",kwlistModel.kw_name];
            klabel.text = kwStr1;
            
            [_view1 addSubview:klabel];
            [klabel release];
            
            cloum++;
            if (cloum % 3 == 0 && cloum < _kwlistData.count) {
                row++;
                cloum = 0;
            }
            
        }
        
        _view1.hidden = YES;
        _isView1 = YES;
    }
    
    if (_view2 == nil) {
        
        _view2 = [[UIView alloc]init];
        _view2.frame = CGRectMake(0, _menuView.bottom, ScreenWidth, ScreenHeight);
        _view2.backgroundColor = [UIColor colorWithRed:0.906 green:0.616 blue:0.467 alpha:0.8];
        
        
        [self.view addSubview:_view2];
        
        int cloum = 0 , row = 0;
        for (int i=0; i<_categorielistData.count; i++) {
            
            
            CategorielistModel *categorielistModel = [[CategorielistModel alloc]initWithDictionary:[_categorielistData objectAtIndex:i] error:Nil];
            
            RTLabel *klabel = [[RTLabel alloc]initWithFrame:CGRectMake(cloum * 100 + 20, row * 25 + 20, 100, 25)];
            klabel.delegate = self;
            NSString *kwStr1 = [NSString stringWithFormat:@"<a href='%d-%d-%@-%@'>%@</a>",4,[categorielistModel.cat_id intValue],[categorielistModel.cat_title URLEncodedString] ,@"cat_id",categorielistModel.cat_title];
            klabel.text = kwStr1;
            
            [_view2 addSubview:klabel];
            [klabel release];
            
            cloum++;
            if (cloum % 3 == 0 && cloum < _categorielistData.count) {
                row++;
                cloum = 0;
            }
            
        }
        
        _view2.hidden = YES;
        _isView2 = YES;

    }
    
    
    if (_view3 == nil) {
        
        _view3= [[UIScrollView alloc]init];
        _view3.frame = CGRectMake(0, _menuView.bottom, ScreenWidth, ScreenHeight);
        _view3.backgroundColor = [UIColor colorWithRed:0.906 green:0.616 blue:0.467 alpha:0.8];
        
        //            [self.view addSubview:_view3];
        [self.view.window addSubview:_view3];
        
        
        int cloum = 0 , row = 0;
        for (int i=0; i<_sclistData.count; i++) {
            
            
            SclistModel *sclistModel = [[SclistModel alloc]initWithDictionary:[_sclistData objectAtIndex:i] error:Nil];
            
            RTLabel *klabel = [[RTLabel alloc]initWithFrame:CGRectMake(cloum * 100 + 20, row * 25 + 20, 100, 25)];
            klabel.delegate = self;
            NSString *kwStr1 = [NSString stringWithFormat:@"<a href='%d-%d-%@-%@'>%@</a>",4,[sclistModel.sc_id intValue],[sclistModel.sc_name URLEncodedString] ,@"sc_id",sclistModel.sc_name];
            klabel.text = kwStr1;
            
            [_view3 addSubview:klabel];
            [klabel release];
            
            cloum++;
            if (cloum % 3 == 0 && cloum < _sclistData.count) {
                row++;
                cloum = 0;
            }
            
        }
        
        _view3.contentSize = CGSizeMake(320, row * 26);
        
        _view3.hidden = YES;
        _isView3 = YES;
        
    }
    
}

- (void)leftItemClicks {
//    [[SliderViewController sharedSliderController] leftItemClick];
}

- (void)_initJson {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    _data = [[NSMutableArray alloc]init];
    
    
    
    [self loadJson:1 type:0 tableView:nil];
}

- (void)loadJson:(int)page type:(int)type tableView:(MJRefreshBaseView*)tableView{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (page > 1) {
        [params setObject:[NSNumber numberWithInt:page] forKey:@"p"];
    }
    
    if (_sc_id.intValue > 0) {
        [params setObject:_sc_id forKey:@"sc_id"];
    }
    
    if (_kw_id.intValue > 0) {
        [params setObject:_kw_id forKey:@"kw_id"];
    }
    
    if (_cat_id.intValue >0){
        [params setObject:_cat_id forKey:@"cat_id"];
    }
    
    LoginShare *loginShare = [LoginShare shareLogin];
    
    if (loginShare.uid > 0) {
         [params setObject:loginShare.uid forKey:@"uid"];
    }
    
    
    
    [JSONHTTPClient getJSONFromURLWithString:RecipesUrl params:params completion:^(id json, JSONModelError *err) {
        
        [self loadJsonFinish:json type:type tableView:tableView];
    }];
    
}

- (void)loadJsonFinish:(NSDictionary *)dic type:(int)type tableView:(MJRefreshBaseView*)tableView{
    
    NSArray *array1 = [dic objectForKey:@"cblists"];
    
    
    if (array1.count >= 14) {
        [_tableVIew.footer setHidden:NO];
    }else{
        [_tableVIew.footer setHidden:YES];
    }
    
    NSNumber* isok = [dic objectForKey:@"ok"];
    if ( isok.intValue == 1) {
        _totalCount = [dic objectForKey:@"totalCount"];
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:array1.count];
        for (int i = 0; i < array1.count; i++) {
            NSDictionary *dic = [array1 objectAtIndex:i];
            RecipesModel *recipesModel = [[RecipesModel alloc]initWithDictionary:dic error:nil];
            [array addObject:recipesModel];
            [recipesModel release];
        }
        if (type == 1) {
            [_data removeAllObjects];
        }
        
        if ([tableView isKindOfClass:[MJRefreshHeaderView class]]) {
            [tableView endRefreshing];
        }
        
        
        
        [_data addObjectsFromArray:array];
        
        
        
        [_tableVIew reloadData];
        
        if (type == 2) {
            
            [tableView endRefreshing];
        }
    }else{
        NSLog(@"没数据");
    }
   [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
}

- (void)_initJsonMenuData{
    
    [JSONHTTPClient getJSONFromURLWithString:RecipesMenuUrl completion:^(id json, JSONModelError *err) {
        
        [self loadJsonMenuDataFinish:json];
    }];
    
}

- (void)loadJsonMenuDataFinish:(NSDictionary *)json{
    
    _sclistData = [[json objectForKey:@"sclist"] retain];
    _categorielistData = [[json objectForKey:@"categorielist"] retain];
    _kwlistData = [[json objectForKey:@"Kwlist"] retain];
    
    [self addViewcategory];
}

#pragma mark 上下拉

- (void)up{
    
    _tableVIew.header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        _kw_id = 0;
        _sc_id = 0;
        
       [self loadJson:1 type:1 tableView:refreshView]; //type = 2 是 下拉
    };
    
    _tableVIew.header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView){
        
        _page = 2;
    };
    
}



- (void)down{
    
    
    _tableVIew.footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [self loadJson:_page type:2 tableView:refreshView]; //type = 2 是 下拉
        
    };
    
    _tableVIew.footer.endStateChangeBlock = ^(MJRefreshBaseView *refreshView){
        
        _page++;
    };
    
    
}

#pragma mark 手势
- (void)swipeAction:(UISwipeGestureRecognizer*)swipe{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}


#pragma mark button Action
- (void)leftAction:(UIButton *)but{
    
    SoViewController *soVC = [[SoViewController alloc]init];
    [self presentViewController:soVC animated:YES completion:nil];
     [soVC release];
    
        soVC.block = ^(NSString *str){
            _keyword = str;
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSDictionary *params = [NSDictionary dictionaryWithObject:_keyword forKey:@"keyword"];
            [JSONHTTPClient getJSONFromURLWithString:RecipesUrl params:params completion:^(id json, JSONModelError *err) {
                [self loadJsonFinish:json type:1 tableView:nil];
                
            }];
            
            
    };
    
    
    
}

#pragma mark UITableView delegate
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

#pragma  mark  rtLabel delegate
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url{
    NSString *urlString = [url absoluteString];
    NSArray * array = [urlString componentsSeparatedByString:@"-"];
    
    /**
     *  type  1 = 口味; 2 = 类别; 3 = 食材; 4 =
     */
    int type = [array[0] intValue];
    
    if ( type == 1) {
        _view2.hidden = YES;
        _isView2 = YES;

        _view3.hidden = YES;
        _isView3 = YES;

        
        if (_isView1) {
            
            
            _view1.hidden = NO;
            _isView1 = NO;
        }else{
            _view1.hidden = YES;
            _isView1 = YES;
            
        }
        
        
    }else if (type == 2){
        _view3.hidden = YES;
        _isView3 = YES;
        
        _view1.hidden = YES;
        _isView1 = YES;
        
        
        if (_isView2) {
            
            _view2.hidden = NO;
            _isView2 = NO;
        }else{
            _view2.hidden = YES;
            _isView2 = YES;
            
        }
 
        
    }else if (type ==3){
        _view2.hidden = YES;
        _isView2 = YES;
        
        _view1.hidden = YES;
        _isView1 = YES;
        
        if (_isView3) {
            
            _view3.hidden = NO;
            _isView3 = NO;
        }else{
            _view3.hidden = YES;
            _isView3 = YES;
            
        }

        
      
        
    }else if(type == 4){
        
        NSLog(@"%@,%@,%@",[array[1] URLDecodedString],[array[2] URLDecodedString],[array[3] URLDecodedString]);
        
        
        if([[array[3] URLDecodedString] isEqualToString:@"sc_id"]){
            _sc_id = (NSNumber*)[array[1] URLDecodedString];
            [_sc_id retain];
            _cat_id = 0;
            _kw_id = 0;
        }
        
        if([[array[3] URLDecodedString] isEqualToString:@"cat_id"]){
            _cat_id = (NSNumber*)[array[1] URLDecodedString];
            [_cat_id retain];
            
            _kw_id = 0;
            _sc_id = 0;
        }
        
        if([[array[3] URLDecodedString] isEqualToString:@"kw_id"]){
            _kw_id = (NSNumber*)[array[1] URLDecodedString];
            [_kw_id retain];
            _sc_id = 0;
            _cat_id = 0;
            
        }
        
        
        [self _initJson];
        
        
        _view1.hidden = YES;
         _view2.hidden = YES;
         _view3.hidden = YES;
        _isView1 = YES;
        _isView2 = YES;
        _isView3 = YES;
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
     
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [MainViewController showTabbars:NO];
}



- (void)reTableView  //刷新tableView
{
    [_tableVIew reloadData];
}

- (void)dealloc {
    NSLog(@"discoverViewController dealloc");
    [_tableVIew release]; 
    [_data release];
    [_sc_id release];
    [_kw_id release];
    [_menuView release];
    
    [_sclistData release];
    [_categorielistData release];
    [_kwlistData release];
    
    [_totalCount release];
    [_keyword release];
    [_view1 release];
    [super dealloc];
}
@end
