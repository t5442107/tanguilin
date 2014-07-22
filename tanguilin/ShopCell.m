//
//  ShopCell.m
//  tanguilin
//
//  Created by yangyuji on 14-2-19.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "ShopCell.h"
#import "UIImageView+WebCache.h"
@implementation ShopCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)awakeFromNib{
    
    _shop_image = (UIImageView *) [self viewWithTag:100];
    _shop_image.layer.borderWidth = 1.00;
    _shop_image.layer.borderColor = [UIColor lightGrayColor].CGColor;
     _shop_image.layer.masksToBounds = YES;
 
    _shop_title =  (UILabel *)[[self viewWithTag:101]retain];
    _shop_tel =  (UILabel *)[[self viewWithTag:102]retain];
    _shop_addr =  (UILabel *) [[self viewWithTag:103]retain]; 
   
    _shop_frist_operate = (UILabel *)[[self viewWithTag:104]retain];
    
    
    _shop_map_m = [[UILabel alloc]initWithFrame:CGRectMake(_shop_frist_operate.right - 60, _shop_frist_operate.top, 80, 25)];
    _shop_map_m.font = [UIFont systemFontOfSize:12];
    _shop_map_m.hidden = YES;
    _shop_map_m.textColor = [UIColor redColor];
    _shop_map_m.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:_shop_map_m];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSString *imageUrl = [NSString stringWithFormat:@"http://www.0773time.com/Public/uploads/shop/icon/120_%@",_shopModel.shop_icon];
    [_shop_image setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"back.png"]];
    _shop_title.text = _shopModel.shop_name;
    _shop_tel.text = _shopModel.shop_phone;
    _shop_addr.text = _shopModel.shop_address;
    _shop_frist_operate.text = _shopModel.shop_frist_operate;
    
    if (_shopModel.shop_map_m > 0) {
        _shop_map_m.hidden = NO;
        _shop_map_m.text= [NSString stringWithFormat:@"距离:%d米",_shopModel.shop_map_m];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
  
    [_shop_image release];
    [_shop_title release];
    [_shop_tel release];
    [_shop_addr release];
    [_shopModel release];
    [_shop_frist_operate release];
    [super dealloc];
}
@end
