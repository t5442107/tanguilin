//
//  CommentListController.m
//  tanguilin
//
//  Created by yangyuji on 14-3-3.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "CommentListController.h"
#import "JSONHTTPClient.h"
#import "ShopInfoCommentCell.h"
@interface CommentListController ()

@end

@implementation CommentListController

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
    _tableView.userInteractionEnabled = YES;
    //初始化下拉
    [_tableView.footer setHidden:YES];
    
    self.title = _shopModel.shop_name;
    _p = 2;
    _commentData  = [[NSMutableArray alloc]init];
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 20 );
    
    //加载评论
    
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInteger:_shopModel.shopid],@"shopid",@"20",@"limit", nil];
    
    [self loadData:params];

    [self upRe];
    
}

#pragma mark data

- (void)loadData:(NSDictionary*)params {
    
    [JSONHTTPClient getJSONFromURLWithString:ShopInfoComment params:params completion:^(id json, JSONModelError *err) {
        [self getCommentData:json];
    }];
    
}

#pragma mark 上拉 下拉

- (void)upRe{
        _tableView.header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
            
             NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInteger:_shopModel.shopid],@"shopid",@"20",@"limit", nil];
             
            [JSONHTTPClient getJSONFromURLWithString:ShopInfoComment params:params completion:^(NSMutableArray* json, JSONModelError *err) {
               
                [_commentData removeAllObjects];
                [_commentData addObjectsFromArray:json];
                [_commentData retain];
                [_tableView reloadData];
                

                 [_tableView.header endRefreshing];
                
            }];
            

            
            
  
           
    };
    
    _tableView.header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView){
        _p = 2;
       
    };
    
    
}

- (void)downRe{
    
    _tableView.footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInteger:_shopModel.shopid],@"shopid",@"20",@"limit",[NSNumber numberWithInt:_p],@"p", nil];
        
        [JSONHTTPClient getJSONFromURLWithString:ShopInfoComment params:params completion:^(NSMutableArray* json, JSONModelError *err) {
            if (json.count > 19) {
                
                [_tableView.footer setHidden:NO];
            }else{
                
                [_tableView.footer setHidden:YES];
            }
             [self getCommentData:json];
           
        }];
        
        
        [_tableView.footer endRefreshing];
    };
    
    _tableView.footer.endStateChangeBlock = ^(MJRefreshBaseView *refreshView){
        
         _p++;
    };

    
}

#pragma mark 
-(void)getCommentData:(NSMutableArray*)json{
    if (json.count > 19) {
        
        [_tableView.footer setHidden:NO];
        [self downRe];
    }
    
    [_commentData addObjectsFromArray:json];
    [_commentData retain];
    [_tableView reloadData];
}

#pragma mark  UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _commentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *ideCell = @"cell";
    
    ShopInfoCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ideCell];
    
    if (cell == nil) {
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"ShopInfoCommentCell" owner:self options:nil]lastObject]  ;
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = view;
        [view release];
        
        
    }
    cell.userInteractionEnabled = YES;
    NSDictionary *dic = [_commentData objectAtIndex:indexPath.row];
    ShopInfoCommentModel *sicm = [[ShopInfoCommentModel alloc]initWithDictionary:dic error:nil];
    cell.shopInfoCommentModel = sicm;
    return cell;

}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [_commentData objectAtIndex:indexPath.row];
    ShopInfoCommentModel *sicm = [[ShopInfoCommentModel alloc]initWithDictionary:dic error:nil];
    
    
    float height = [ShopInfoCommentCell getCellHeight:sicm tableview:tableView];
     
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([_replyView isKindOfClass:[UIView class]]) {
        [_replyView removeFromSuperview];
    }
    
    [self showReply:tableView didSelectRowAtIndexPath:indexPath];
    
    
    
}

- (void)showReply:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopInfoCommentCell *cell = (ShopInfoCommentCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    NSDictionary *dic = [_commentData objectAtIndex:indexPath.row];
    ShopInfoCommentModel *sicm = [[ShopInfoCommentModel alloc]initWithDictionary:dic error:nil];
    
    _replyView = [[UIView alloc]init];
    _replyView.alpha = 0;
    
    float y = cell.top + 40;
    float imageY = -5;
    UIImageView *imageV1 =[[UIImageView alloc]init];
    UIImage *image1 = Nil;
    
    if ((cell.bottom + 40) > ScreenHeight) {
        y = cell.top - 60;
        image1 = [UIImage imageNamed:@"popoverArrowDownSimple.png"];
        imageY = 80 - 5;
    }else{
        image1 = [UIImage imageNamed:@"popoverArrowUpSimple.png"];
    }
    
    imageV1.image = [UIImage imageNamed:@"popoverArrowUpSimple.png"];
    imageV1.frame = CGRectMake(10, -5, 18, 13);
    _replyView.frame = CGRectMake(cell.username.left, cell.username.bottom, 80, 40);
    UIImage *imageBG = [[UIImage imageNamed:@"popoverBgSimple.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    UIImageView *imageV = [[UIImageView alloc]initWithImage:imageBG];
    imageV.frame = CGRectMake(0, 0,80, 50);
    
    [imageV addSubview:imageV1];
    
    
    
    _replyView.backgroundColor = [UIColor clearColor];
    [_replyView addSubview:imageV];
    [imageV release];
    
    [UIView animateWithDuration:0.7 animations:^{
        _replyView.alpha = 1;
//        [tableView addSubview:_replyView];
        [cell.contentView addSubview:_replyView]; 
    }  ];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 40, 30);
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"回复" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.tag = (int)sicm;
    [button addTarget:self action:@selector(reButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_replyView addSubview:button];
    
    
	 
    
    _replyView.frame = [cell.contentView convertRect:_replyView.frame toView:self.view];
    [self.view addSubview:_replyView];
    
    self.view.autoresizingMask = ( UIViewAutoresizingFlexibleLeftMargin |
									  UIViewAutoresizingFlexibleRightMargin);
    

}



- (void)reButtonAction:(UIButton*)button{
    ShopInfoCommentModel *sicm = (ShopInfoCommentModel*)button.tag;
    NSLog(@"%@",sicm);
    if ([_replyView isKindOfClass:[UIView class]]) {
        [_replyView removeFromSuperview];
    }
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
    [_shopModel release];
    [_commentData release];
    [_replyView release];
}
@end
