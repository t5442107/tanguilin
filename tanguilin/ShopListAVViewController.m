//
//  ShopListAVViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-2-25.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "ShopListAVViewController.h"
#import "ShopCell.h"
#import "ShopModel.h"
#import "ShopInfoViewController.h"
@interface ShopListAVViewController ()

@end

@implementation ShopListAVViewController

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
	 
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight + 49) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    [self.view addSubview:_tableView];
}


#pragma mark UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _data.count;
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
    
    ShopModel *shopModel = [[ShopModel alloc]initWithDictionary:[_data objectAtIndex:indexPath.row] error:nil];
    
   
    
    
    cell.shopModel = shopModel;
    
  
    
    
    return cell;

}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}
 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopModel *shopModels = [[ShopModel alloc]initWithDictionary:[_data objectAtIndex:indexPath.row] error:nil];;
    ShopInfoViewController *shopInfoVC = [[ShopInfoViewController alloc]init];
    shopInfoVC.shopMode = shopModels;
    [self.navigationController pushViewController:shopInfoVC animated:YES];
    [shopInfoVC release];
    
}



- (void)dealloc
{
    [super dealloc];
    if (_tableView != nil) {
        [_tableView release];
        _tableView = nil;
    }
//    [_data release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
