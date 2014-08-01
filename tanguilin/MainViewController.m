//
//  MainViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-2-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "MainViewController.h"

#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationController.h"
#import "RecipesInfoViewController.h"

#define tabbarHeight self.tabBar.bounds.size.height
#define tabbarWidth self.tabBar.bounds.size.width 

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBar.hidden = YES;
        [self _initViewController];
        [self _initTabbarView];
        
        
    }
    return self;
}
- (BOOL)shouldAutorotate{
    return NO;
}
- (tanguilinAppDelegate*)appDelegate {
    tanguilinAppDelegate *appDelegate = (tanguilinAppDelegate *)[UIApplication sharedApplication].delegate;
    
    return appDelegate;
}




- (void)_initViewController {
     
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    MessageViewController *messageVC = [[MessageViewController alloc]init];
    ProfileViewController *profileVC = [[ProfileViewController alloc]init];
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc]init];
    MoreViewController *moreVC = [[MoreViewController alloc]init];
    
    NSArray *views = @[homeVC,messageVC,profileVC,discoverVC,moreVC];
    
    [homeVC release];
    [messageVC release];
    [profileVC release];
    [discoverVC release];
    [moreVC release];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    
    for (UIViewController *viewController in views) {
        
        BaseNavigationController *baseNC = [[[BaseNavigationController alloc]initWithRootViewController:viewController]autorelease];
        [viewControllers addObject:baseNC];
        baseNC.delegate = self;
        [baseNC release];
        
    }
    
    self.viewControllers = viewControllers;
    
}

- (void)showTabbar:(BOOL)show
{
    [UIView animateWithDuration:0.2 animations:^{
        if (show) {
            _tabbarView.left = 0;
        }else
        {
            _tabbarView.left = - ScreenWidth;
        }
    }];
    
    
//    [self _resizeView:show];
    
}

+ (void)showTabbars:(BOOL)show{
    MainViewController *mainVC =[[MainViewController alloc]init];
     [mainVC showTabbar:show];
}

 
//初始化子控制器

#pragma mark Ui

- (void)_resizeView:(BOOL)showTabbar{
    
    for (UIView *subView in self.view.subviews) {
        
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            float heig = ScreenHeight == 480? ScreenHeight-22:ScreenHeight-22-49-44;
            if (showTabbar) {
                
                subView.height = heig;
            }else{
                subView.height = heig - 20;
            }
        }
    }
}

- (void)_initTabbarView {
    
    _tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - tabbarHeight, tabbarWidth, tabbarHeight)];
    //tabbar 背景
//    _tabbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    _tabbarView.backgroundColor = [UIColor colorWithRed:0.404 green:0.388 blue:0.369 alpha:0.8];
    [self.view addSubview:_tabbarView];
    
    NSArray *backgroud = @[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    
    
    NSArray *heightBackgroud = @[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
    
    _backgroud = [backgroud copy];
    _heightBackgroud = [heightBackgroud copy];
    
    
    for (int i = 0; i < backgroud.count; i++) {
        NSString *backImage = backgroud[i];
        NSString *heightImage = heightBackgroud[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((64 - 30)/2 + (64 * i), (tabbarHeight  - 30) /2, 30, 30);
        button.tag = (i + 100);
        
        //图标默认第一个为高亮
        if (i == 0) {
            [button setImage:[UIImage imageNamed:heightImage] forState:UIControlStateNormal];
        }
        else{
            [button setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
        }
        
        [button setImage:[UIImage imageNamed:heightImage] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:heightImage] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        
        [_tabbarView addSubview:button];
    }
    
    
    _sideImageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_slider.png"]]retain];
    _sideImageView.frame = CGRectMake((64 - 15) /2, 5, 15, 44);
    
    _sideImageView.backgroundColor = [UIColor clearColor];
    [_tabbarView addSubview:_sideImageView];
    
    
}

#pragma mark navigationController delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
   
    
    
    int count = navigationController.childViewControllers.count;
    
    if (count == 2) {
        [self showTabbar:NO];
    }else if (count == 1){
        [self showTabbar:YES];
    }
    
    if ([viewController isKindOfClass:[DiscoverViewController class]]) {
         [self showTabbar:YES];
    }
    
    if ([viewController isKindOfClass:[RecipesInfoViewController class]]) {
        [self showTabbar:NO];
    }
    
    
}

#pragma mark - Action button
- (void)selectedTab:(UIButton *)button{
    
    
//点击图标设为高亮，
    
    for (int i = 0; i < _backgroud.count; i++) {
        
        UIButton * but = (UIButton*)[_tabbarView viewWithTag:i + 100];
        
        if (button.tag - 100 == i) {
            [but setImage:[UIImage imageNamed:_heightBackgroud[i]] forState:UIControlStateNormal];
        }else{
            [but setImage:[UIImage imageNamed:_backgroud[i]] forState:UIControlStateNormal];
        }
        
    }
    
    
    
    
    float x = button.left + (button.width-_sideImageView.width) /2 ;
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
//        CGRect newframe = _sideImageView.frame;
//        newframe.origin.x = x;
//        _sideImageView.frame = newframe;
            _sideImageView.left = x;
    }];
    
//    if (button.tag - 100 == self.selectedIndex && button.tag- 100 == 0) {
    
        //        UINavigationController *homeNav = [self.viewControllers objectAtIndex:0];
        //        HomeViewController *homeCtrl = [homeNav.viewControllers objectAtIndex:0];
        //        [homeCtrl refreshWeibo];
        
//        [_home refreshWeibo];
        
//    }
    
    
    self.selectedIndex = button.tag -100;
    
   
   
    
    
     
}












- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view.
}


@end
