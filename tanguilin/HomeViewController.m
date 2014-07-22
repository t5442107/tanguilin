//
//  HomeViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-2-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//  有什么问题 请到 加入QQ群 170627662 ，提问，我会尽力回答大家的

#import "HomeViewController.h"


#import "JSONHTTPClient.h"
#import "UIImageView+WebCache.h"

#import "ShopCell.h"
#import "ShopInfoViewController.h"
#import "WebViewController.h"
#import "LoginShare.h"
#import "SoHomeViewController.h"

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.title = @"探桂林网";
        self.hdpData = [NSMutableArray array];
//        _shops = [NSMutableArray array];
        _page = 2;
        self.isLoginButton = YES;
        self.isUserImage = YES;
        
     }
    return self;
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //开启左滑，右滑菜单
    
    [self.appDelegate.ddmenu setEnableGesture:NO];
    _menu.hidden = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //禁用 左滑，右滑菜单
    
    [self.appDelegate.ddmenu setEnableGesture:NO];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(320/2 - 120/2, 0, 100, 50)];
    
    titleText.backgroundColor = [UIColor clearColor];
    
    titleText.textColor=[UIColor whiteColor];
    
    [titleText setFont:[UIFont boldSystemFontOfSize:17.0]];
    
    [titleText setText:@"探桂林网"];
    
    self.navigationItem.titleView=titleText;
    
    [titleText release];
    
    
    
     
    
    
     
    
    // 只有一个 scrollsToTop 才能滚回顶部
    _scrollView.scrollsToTop = NO;
    _tableView.scrollsToTop = YES;
    _tableView.tag = 2015;
     _shops = [[NSMutableArray alloc]init];
     _lastPosition = 0 ;
    
    
    float heig = ScreenHeight == 480? ScreenHeight-22:ScreenHeight-22-49-44;
    _tableView.frame = CGRectMake(0, 25, 320, heig);
     
    _params = [[NSMutableDictionary dictionary]retain];
    //桂林区数据 中山中路 十字街 秀峰区 叠彩区 象山区 七星区 雁山区 阳朔县 临桂县 灵川县
    
    _arrayGL = @[@"全区",@"中山中路",@"十字街",@"秀峰区",@"叠彩区",@"象山区",@"七星区",@"雁山区",@"阳朔县",@"临桂县",@"灵川县"];
    [_arrayGL retain];
    
    float menuHeight = 0;
    
    if (WXHLOSVersion() >= 7) {
        menuHeight = 20+44;
    }
    
    
    _menu = [[UIView alloc]init];
    _menu.frame = CGRectMake(0, menuHeight, 320, 30);
    _menu.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_menu];
    
    
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, _menu.height)];
    scrollview.scrollsToTop = NO;
    scrollview.contentSize = CGSizeMake(50 * _arrayGL.count, _menu.height);
    scrollview.showsHorizontalScrollIndicator = NO;
    [_menu addSubview:scrollview];
    [scrollview release];
    int x = 0;
    for (int i = 0; i < _arrayGL.count; i++) {
        NSString* gl_name =  (NSString*)[_arrayGL objectAtIndex:i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        button.tag = i;
        //得到宽度
        CGSize maxSize=CGSizeMake(MAXFLOAT,  0.0);
        CGSize  sizeName = [gl_name sizeWithFont:button.titleLabel.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
         
        button.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
        button.frame = CGRectMake( x , 0, sizeName.width, 30);
        x +=  sizeName.width + 10;
        
        
        [button setTitle:gl_name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
       
        
        
        [button addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollview addSubview:button];
        
        
        
    }
    
    _menuBack = [[UIView alloc]initWithFrame:CGRectMake(0, scrollview.height - 2, 25, 2)];
    _menuBack.backgroundColor = [UIColor redColor];
    [scrollview addSubview:_menuBack];
    
    [self getHdp];
    
    
        
        //获取shop 列表
        [JSONHTTPClient getJSONFromURLWithString:ShopListUrl completion:^(id json, JSONModelError *err) {
            [self loadShopData:json];
            
            [self downFoot];
        }];
    
    
   
    
     [self upHeader];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 40, 40);
    [leftButton setTitle:@"搜索" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(leftClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem =  leftButtonItem;
    [leftButtonItem release];
    
   
    
    
   
    
}
 //获取首页幻灯片数据
- (void)getHdp{
    
    //获取首页幻灯片数据
    [JSONHTTPClient getJSONFromURLWithString:IndexHdpUrl completion:^(id json, JSONModelError *err) {
        [self loadHdpData:json];
        
    }];

}

#pragma mark Action

- (void)menuAction:(UIButton *)button{
    float x = button.frame.origin.x;
    float width = button.frame.size.width;
    int taps = button.tag;
    
    [UIView animateWithDuration:0.3 animations:^{
        _menuBack.frame = CGRectMake(x, button.frame.size.height - 2, width, 2);
    }];
    
   NSString *circle = ( NSString *)[_arrayGL objectAtIndex:taps];
    
    
    if([circle isEqualToString:@"全区"]){
        [_params removeAllObjects];
    }else{
        [_params setObject:circle forKey:@"circle"];
    }
    
   [_header beginRefreshing];
}

- (void)leftClickAction:(UIButton*)but{
    
    SoHomeViewController *soHomeVC = [[SoHomeViewController alloc] init];
    
    [self presentViewController:soHomeVC animated:YES completion:nil];
    
    
//    [self.navigationController pushViewController:soHomeVC animated:YES];
    [soHomeVC release];
    
    soHomeVC.block = ^(NSString *str){
        
        
        _keyword = str;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [_params setObject:_keyword forKey:@"keyword"];
        
        [JSONHTTPClient getJSONFromURLWithString:ShopListUrl params:_params completion:^(id json, JSONModelError *err) {
            
            [self loadShopData:json];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }];
        
        
        
        
        
    };
    
}



#pragma mark 上拉
- (void)upHeader{
    _header = [[MJRefreshHeaderView alloc]init];
    _header.delegate = self;
    _header.scrollView = self.tableView;
    
    [self getHdp];
}

#pragma mark 下拉
- (void)downFoot{
    _foot = [[MJRefreshFooterView alloc]init];
    _foot.delegate = self;
    _foot.scrollView = self.tableView;
    
}

#pragma mark Data 数据

- (void)loadShopData:(NSMutableArray *)dic{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:dic.count];
    
    for (NSDictionary *shopDic in dic) {
        ShopModel *shopMode = [[ShopModel alloc]initWithDictionary:shopDic error:Nil];
        [array addObject:shopMode];
        [shopMode release];
    }
    self.shops = array;
   
//    [self.shops addObjectsFromArray:dic];
//    self.shops = dic;
    
    [_tableView reloadData];
    
    
    
}

- (void)loadHdpData:(NSDictionary*)dic{
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //table 幻灯片大图
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    [_tableView setTableHeaderView:_headView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
     arrayM = [[NSMutableArray array]retain];
    self.hdpData = [dic objectForKey:@"slidelists"];
    //创建
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, _headView.height)]; 
    _scrollView.pagingEnabled = YES;
    
    _scrollView.scrollsToTop = NO;
   
    
    
    if (self.hdpData.count > 0 ) {
        for (int i = 0; i < self.hdpData.count; i++) {
            
            HdpIndexModel *hdpModel = [[HdpIndexModel alloc]initWithDictionary:[_hdpData objectAtIndex:i] error:Nil]; 
           
            [arrayM addObject:hdpModel];
            
        }
        
        HdpIndexModel *first = [arrayM firstObject];
        HdpIndexModel *last = [arrayM lastObject];
        [arrayM addObject:first];
        [arrayM insertObject:last atIndex:0];
        
        for (int i = 0; i <arrayM.count; i++) {
            HdpIndexModel *hdpModel = [arrayM objectAtIndex:i];
            NSMutableString *url = [NSMutableString stringWithFormat:@"http://www.0773time.com/Public/uploads/slide/%@",hdpModel.slide_pic];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 * i, 0, 320, 160)];
            imageView.tag = (int)hdpModel.slide_url;
            
            imageView.userInteractionEnabled = YES;
            [imageView setImageWithURL:[NSURL URLWithString:url]];
            [_scrollView addSubview:imageView];
            [imageView release];
            
            UILabel *textLabel = [[UILabel alloc]init];
            textLabel.text = hdpModel.slide_title;
            textLabel.tag = 10 +i;
            [_scrollView addSubview:textLabel];
            
            UITapGestureRecognizer *webTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(webTab:)];
            [imageView addGestureRecognizer:webTap];
            [webTap release];
            
        }
 
    }
    
    _scrollView.contentSize =  CGSizeMake(320 * arrayM.count, 160);
    _scrollView.delegate = self;
    _scrollView.contentOffset = CGPointMake(320, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.tag = 2014;
    [_headView addSubview:_scrollView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _scrollView.bottom - 20, ScreenWidth, 20)];
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.7;
    [_headView addSubview:view];
    
    
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(320 - 70, 0, 60, 20)];
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
//    pageControl.defersCurrentPageDisplay = NO;
    [pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    pageControl.enabled = NO;
    [view addSubview:pageControl];
    
    //数据
    
    HdpIndexModel *hdp = [[HdpIndexModel alloc]initWithDictionary:[self.hdpData objectAtIndex:0] error:nil];
    _noteTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth - 60, 20)];
    _noteTitle.backgroundColor = [UIColor clearColor];
    [_noteTitle setText:hdp.slide_title];
    _noteTitle.font = [UIFont systemFontOfSize:12.0];
    [view addSubview:_noteTitle];
    
    [view release];
    
    
}



#pragma mark tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _shops.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ide = @"shopCell";
    
    ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:ide];
    
    if (cell == nil) { 
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopCell" owner:self options:nil]lastObject];
        //设置选中cell 的背景颜色
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0.0 alpha:0.05];
        cell.selectedBackgroundView = view;
        [view release];
//        cell.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0.0 alpha:0.05];
    }
//    NSDictionary *dic = [_shops objectAtIndex:indexPath.row];
    
     ShopModel *shopModel = [_shops objectAtIndex:indexPath.row];
    
    cell.shopModel = shopModel;
 
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.00;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopModel *shopModels = [_shops objectAtIndex:indexPath.row];
    ShopInfoViewController *shopInfoVC = [[ShopInfoViewController alloc]init];
    shopInfoVC.shopMode = shopModels;
    [self.navigationController pushViewController:shopInfoVC animated:YES];
    [shopInfoVC release];
    
}

#pragma mark - MJRefreshBaseView delegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        [_params removeObjectForKey:@"p"];
        [_params removeObjectForKey:@"keyword"];
    }
    
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
    
        [_params setValue:[NSNumber numberWithInteger:_page] forKey:@"p"];
        
    }
    
    NSLog(@"pam stat = %@",_params);
    
        [JSONHTTPClient getJSONFromURLWithString:ShopListUrl params:_params  completion:^(NSArray * json, JSONModelError *err) {
            
            
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in json) {
                ShopModel *shopModel = [[ShopModel alloc]initWithDictionary:dic error:Nil];
                [array addObject:shopModel];
                [shopModel release];
                
            }
            
            if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
                 [_shops removeAllObjects];
                
                
            }
            [_foot setHidden:NO];
            if (json.count < 9) {
                [_foot setHidden:YES];
                
                
            }
            
            [_shops addObjectsFromArray:array];
            [array release];
            //        [_shops retain];
            [refreshView endRefreshing];
        }];
    
    
    
    
    
    
    
}

- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView{
    
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        _page = 2;
        
       
    }else{
        _page++;
        
    }
    
    NSLog(@"刷新成功 page = %d",_page);
    NSLog(@"pam end = %@",[_params objectForKey:@"circle"]);
    [_tableView reloadData];
    
      [self getHdp];
 }

#pragma mark -UIScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.tag == 2014) {
        
        int offset = scrollView.contentOffset.x / 320;
        
        HdpIndexModel *hdp = [arrayM objectAtIndex:offset];
        [_noteTitle setText:hdp.slide_title];
        
        pageControl.currentPage = offset - 1;
        
        if (offset == 0) {
            [scrollView setContentOffset:CGPointMake(320 * 5, 0) animated:NO];
            offset = 1;
            pageControl.currentPage = 5;
        }
        
        if (offset == 6) {
            [scrollView setContentOffset:CGPointMake(320 , 0) animated:NO];
            offset = 5;
            pageControl.currentPage = 0;
        }
        
        
        

    }
    
    
    
    
}



/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.tag == 2015) {
        int currentPostion = scrollView.contentOffset.y;
        
        if (currentPostion - _lastPosition > 25 && currentPostion > 0) {
            _lastPosition = currentPostion;
            
            _menu.hidden = YES;
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            
        }else if((_lastPosition - currentPostion > 20) && (currentPostion <= scrollView.contentSize.height - scrollView.bounds.size.height - 20))
        {
            _lastPosition = currentPostion;
            
            _menu.hidden = NO;
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }
    
}
 
 */

#pragma mark UITapGestureRecognizer Action
- (void)webTab:(id)sender{
    
    UITapGestureRecognizer*tap = (UITapGestureRecognizer*)sender;
    
    UIImageView*imageViews = (UIImageView*) tap.view;
    
    NSString *oldUrl = (NSString*)imageViews.tag;
    
    NSString *hasHttp = @"http://";
    
    NSString *url = @"";
    
    if ([oldUrl hasPrefix:hasHttp]) {
        url = [NSString stringWithFormat:@"%@",oldUrl];
    }else{
        url = [NSString stringWithFormat:@"http://www.0773time.com%@",oldUrl];
    }
    
    
    
    
    
    NSString *temp = @"&amp;";
     WebViewController *webVC = [[WebViewController alloc]init];
     NSString *newUrl = @"";
    
    NSRange rang = [url rangeOfString:temp];
    
    if (rang.length >0 ) {
        newUrl = [url stringByReplacingCharactersInRange:rang withString:@"&"];
    }else{
        newUrl = url;
    }
    
    
    
    webVC.url = newUrl;
    [self.navigationController pushViewController:webVC animated:YES];
    [webVC release];
    
}


- (void)dealloc {
    NSLog(@"dealloc-------------------");
//    [_hdpModel release],_headView=nil;
    [_scrollView release];
    [_hdpData release];
    [_tableView release];
    [_shops release];
    [_header release];
    [_foot release];
    [_arrayGL release];
    [_params release];
    [_menu release];
    [super dealloc];
}
@end
