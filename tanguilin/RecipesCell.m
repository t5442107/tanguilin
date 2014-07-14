//
//  RecipesCell.m
//  tanguilin
//
//  Created by yangyuji on 14-3-11.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "RecipesCell.h"
#import "UIImageView+WebCache.h"
#import "JSONHTTPClient.h"
#import "UIUtils.h"
#import "NSString+HTML.h"
#import "LoginShare.h"
#import "LoginViewController.h"
#import "DiscoverViewController.h"
@implementation RecipesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self _initView];
    }
    return self;
}


- (void)awakeFromNib {
    [self _initView];
}

- (void)_initView{
    
    _titleLabel.frame = CGRectZero;
    _jianJieLabel.frame = CGRectZero;
}

//返回高度
+ (float)getCellHeight:(RecipesModel*)recipesModel tableview:(UITableView*)tableview{
    
    // 列寬
    CGFloat contentWidth =  tableview.frame.size.width - 20;
    // 用何種字體進行顯示
    UIFont *cb_title_font = [UIFont boldSystemFontOfSize:14];
    UIFont *jianJie_font = [UIFont systemFontOfSize:13];
    // 該行要顯示的內容
    NSString *content = [UIUtils getText:recipesModel.cb_title];
    NSString *jianJie_content = [UIUtils getText:recipesModel.cb_tese];
    // 計算出顯示完內容需要的最小尺寸
    CGSize title_size = [content sizeWithFont:cb_title_font constrainedToSize:CGSizeMake(contentWidth, 9999) lineBreakMode:NSLineBreakByWordWrapping];
     CGSize jianJie_size = [jianJie_content sizeWithFont:jianJie_font constrainedToSize:CGSizeMake(contentWidth, 9999) lineBreakMode:NSLineBreakByWordWrapping];
    
    float f_width = 0 ;
    float f_height = 0;
    float width = recipesModel.cb_icon_width.floatValue;
    float height = recipesModel.cb_icon_height.floatValue;
    if (width > 300 || width < 300) {
        
        f_width =    300 - width ;
        f_height = height + f_width;
    }

    
    return title_size.height + jianJie_size.height + f_height + 50 ;
    
    
    
    }





- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSString *strUrl = Nil;
    
    
        strUrl =[NSString stringWithFormat:@"http://www.0773time.com/Public/uploads/food/cookbook/icon/%@%@",_recipesModel.cb_icon_u,_recipesModel.cb_icon];
     
    
    NSURL *ImageUrl = [NSURL URLWithString:strUrl];
    
    float f_width = 0 ;
    float f_height = 0;
    float width = _recipesModel.cb_icon_width.floatValue;
    float height = _recipesModel.cb_icon_height.floatValue;
    if (width > 300 || width < 300) {
        
        f_width =    300 - width ;
        f_height = height + f_width;
    }
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, f_height)];
    
    [_imageView setImageWithURL:ImageUrl placeholderImage:[UIImage imageNamed:@"RecipesIcon.png"]];
    
    [self.contentView addSubview:_imageView];
    
    _titleLabel.text = [UIUtils getText:_recipesModel.cb_title];
    //设置自动行数与字符换行
    [_titleLabel setNumberOfLines:0];
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UIFont *title_font = [UIFont boldSystemFontOfSize:14];
    //设置一个行高上限
    CGSize title_size = CGSizeMake(ScreenWidth - 20,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize title_size_line = [_titleLabel.text sizeWithFont:title_font constrainedToSize:title_size lineBreakMode:NSLineBreakByWordWrapping];
    
    _titleLabel.frame = CGRectMake(_imageView.left, _imageView.bottom + 5, title_size.width, title_size_line.height);
    
    //
    
    _jianJieLabel.text =  [[UIUtils getText:_recipesModel.cb_tese] stringByConvertingHTMLToPlainText] ;
    
    //设置自动行数与字符换行
    [_jianJieLabel setNumberOfLines:0];
    _jianJieLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UIFont *jianJie_font = [UIFont systemFontOfSize:13];
    //设置一个行高上限
    CGSize jianJie_size = CGSizeMake(ScreenWidth - 20,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize jianJie_size_line = [_jianJieLabel.text sizeWithFont:jianJie_font constrainedToSize:jianJie_size lineBreakMode:NSLineBreakByWordWrapping];
    _jianJieLabel.frame = CGRectMake(_imageView.left, _titleLabel.bottom + 5, jianJie_size.width, jianJie_size_line.height);
    
    
    
    //创建 收藏 按扭
    if (_shouChangButton == nil) {
        _shouChangButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _shouChangButton.frame = CGRectMake( _imageView.right -  80, _jianJieLabel.bottom, 80, 30);
        
        if (_recipesModel.isshouchang.intValue == 1) {
            [_shouChangButton setTitle:@"已收藏" forState:UIControlStateNormal];
        }else
        {
            [_shouChangButton setTitle:@"收藏" forState:UIControlStateNormal];
            
        }
        [_shouChangButton addTarget:self action:@selector(shouChangAction:) forControlEvents:UIControlEventTouchUpInside];
        [_shouChangButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _shouChangButton.backgroundColor  = [UIColor clearColor];
        _shouChangButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
       
//        _shouChangButton.tag = (int)_recipesModel;
        [self addSubview:_shouChangButton];
    }
    
    
}

- (IBAction)shouChangAction:(id)sender {
    
    LoginShare *loginShare = [LoginShare shareLogin];
    
    
    if (!loginShare.uid) {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.viewVC presentViewController:loginVC animated:YES completion:nil];
        [loginVC release];
        return;
    }
    
    //判断 是否有收藏ID 如果有进入删除收藏id地址。否，进入添加收藏ID
    if (_recipesModel.sccb_id.intValue > 0)
    {
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:loginShare.identifier,@"identifier",_recipesModel.cbid,@"cbid",_recipesModel.sccb_id,@"sccb_id", nil];
        
        [JSONHTTPClient postJSONFromURLWithString:RecipesDelCollectUrl params:params completion:^(id json, JSONModelError *err) {
            [self delData:json];
        }];
        
    }
    else
    {
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:loginShare.identifier,@"identifier",_recipesModel.cbid,@"cbid", nil];
        
        [JSONHTTPClient postJSONFromURLWithString:RecipesAddCollectUrl params:params completion:^(id json, JSONModelError *err) {
            [self postData:json];
            
        }];
        
    }
    
    
}

- (void)postData:(NSDictionary*)sdic
{
       NSNumber * status = (NSNumber*)[sdic objectForKey:@"status"];
    
    if (status.intValue == 1) {
        
        NSLog(@"以收藏成功");
        _recipesModel.isshouchang = [NSNumber numberWithInt:1];
        [_shouChangButton setTitle:@"已收藏" forState:UIControlStateNormal];
    }
}

- (void)delData:(NSDictionary *)sdic{
     NSNumber * status = (NSNumber*)[sdic objectForKey:@"status"];
     if (status.intValue == 1)
     {
          NSLog(@"以删除成功");
         _recipesModel.isshouchang = [NSNumber numberWithInt:0];
         [_shouChangButton setTitle:@"收藏" forState:UIControlStateNormal];
     }
}

- (void)dealloc
{
    [_imageView release];
    [_titleLabel release]; 
    [_jianJieLabel release]; 
//    [_shouChangButton release];
    [super dealloc];
//    [_recipesModel release];
}

@end
