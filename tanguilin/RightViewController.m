//
//  RightViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-3-14.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "RightViewController.h"
#import "LoginShare.h"
#import "UIImageView+WebCache.h"
#import "MyRecipesViewController.h"
#import "BaseNavigationController.h"
@implementation RightViewController

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
    self.navigationController.navigationBarHidden = YES;
    //背景图
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"userbg"]];
    bgView.frame = self.view.bounds; 
    [self.view addSubview:bgView];
    [bgView release];
    
    
    //用户头像
    UIImageView *userImage  =[[UIImageView alloc]init];
    LoginShare *login = [[LoginShare alloc]init];
    NSLog(@"%@",login.uid);
     NSString *imgUrl = [NSString stringWithFormat:@"%@%d",UserFaceImage,login.uid.intValue];
    [userImage setImageWithURL:[NSURL URLWithString:imgUrl]];
    userImage.frame = CGRectMake(ScreenWidth/2 - 100/2, 100, 100, 100);
    userImage.layer.cornerRadius = 18.0f;
    userImage.layer.masksToBounds = YES;
    userImage.layer.borderWidth = 3;
    userImage.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:userImage];
    [userImage release];
    
    
    //用户名
    UILabel *usernameLabel = [[UILabel alloc]init];
    usernameLabel.frame = CGRectMake(userImage.left, userImage.bottom + 10, 100, 30);
    usernameLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    usernameLabel.text = login.username;
    usernameLabel.textColor = [UIColor redColor];
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:usernameLabel];
    [usernameLabel release];
    
    //创建我的菜普收藏按扭
    
    UIButton *recipesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    recipesButton.frame =  CGRectMake(60, usernameLabel.bottom + 10 , 100, 60) ;
    [recipesButton setTitle:@"我的菜普收藏" forState:UIControlStateNormal];
    [recipesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    recipesButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [recipesButton addTarget:self action:@selector(recipesAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recipesButton];
    
    
    //创建注销登陆
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame =  CGRectMake(recipesButton.left, recipesButton.bottom + 10 , 100, 60) ;
    [logoutButton setTitle:@"注销登陆" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logoutButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
    
    
}

 

- (void)recipesAction{
    
    MyRecipesViewController *myRC = [[MyRecipesViewController alloc]init];
    
    [self.appDelegate.ddmenu.navigationController pushViewController:myRC animated:YES];
     
    [myRC release];
    
}

- (void)logoutAction
{
      
    LoginShare *loginShare = [LoginShare shareLogin];
    [loginShare removeUid];
    loginShare.uid = nil;
    loginShare.identifier = nil;
    loginShare.username = nil;
    //通知  发送通知 改用户登陆 状态
    [[NSNotificationCenter defaultCenter] postNotificationName:loginStatusRemoveNotificationCenter object:nil];
    
    [self.appDelegate.ddmenu showRootController:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
