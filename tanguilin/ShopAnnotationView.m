//
//  ShopAnnotationView.m
//  tanguilin
//
//  Created by yangyuji on 14-2-24.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "ShopAnnotationView.h"
#import "ShopAnnotation.h"
#import "UIImageView+WebCache.h"
@implementation ShopAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initView];
    }
    return self;
}

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        [self _initView];
    }
    return self;
}

- (void)_initView{
    _backView = [[UIView alloc] initWithFrame:CGRectZero];
    _backView.backgroundColor = [UIColor whiteColor];
    
    
//    [self addSubview:_backView];
    
    _shop_icon = [[UIImageView alloc]initWithFrame:CGRectZero];
    _shop_icon.userInteractionEnabled = YES;
    _shop_icon.layer.borderColor = [UIColor whiteColor].CGColor;
    _shop_icon.layer.borderWidth = 1;
    _shop_icon.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_shop_icon];
    
    _shop_name = [[UILabel alloc]initWithFrame:CGRectZero];
    _shop_name.font = [UIFont boldSystemFontOfSize:16.0f];
    [_shop_name setLineBreakMode:NSLineBreakByCharWrapping];
    _shop_name.textColor = [UIColor blackColor];
    _shop_name.backgroundColor = [UIColor clearColor];
//    [self addSubview:_shop_name];
    _shop_phone = [[UILabel alloc]initWithFrame:CGRectZero];
    _shop_phone.font = [UIFont systemFontOfSize:13.0f];
    _shop_phone.textColor = [UIColor redColor];
    _shop_phone.backgroundColor = [UIColor clearColor];
    
    _shop_address = [[UILabel alloc]initWithFrame:CGRectZero];
    _shop_address.font = [UIFont systemFontOfSize:13.0f];
    _shop_address.textColor = [UIColor blackColor];
    _shop_address.backgroundColor = [UIColor clearColor];
     [_shop_address setLineBreakMode:NSLineBreakByCharWrapping];
//
//     [self addSubview:_shop_phone];
//     [self addSubview:_shop_address];
    
    
    ShopAnnotation *shopA = (ShopAnnotation *) self.annotation;
    _shopModel = nil;
    if ([shopA isKindOfClass:[ShopAnnotation class]]) {
        _shopModel = shopA.shopModel;
    }
    
    
    
}





- (void)layoutSubviews{
    [super layoutSubviews];
    
    
//     self.image =  [UIImage imageNamed:@"nearby_map_content2.png"];
   
    
   
    
    
    
    
    _shop_icon.frame = CGRectMake(10, 10, 50, 45);

    NSURL *imgUrl =  [NSURL URLWithString:[NSString stringWithFormat:@"http://www.0773time.com/Public/uploads/shop/icon/120_%@",_shopModel.shop_icon]];
    [_shop_icon setImageWithURL:imgUrl];
    _shop_name.frame = CGRectMake(_shop_icon.right + 10, 10, 140, 25);
    _shop_name.text = _shopModel.shop_name;
    
    _shop_phone.frame = CGRectMake(_shop_name.left, _shop_name.bottom + 5, 140, 20);
    _shop_phone.text = _shopModel.shop_phone;
    
    _shop_address.frame = CGRectMake(_shop_name.left, _shop_phone.bottom +1, 140, 30);
    _shop_address.text = _shopModel.shop_address;
    
    
    
    
    
    
    
    
}

- (void)dealloc
{
    NSLog(@"ShopAnnotationView dealloc");
    [super dealloc];
    [_shop_address release];
    [_shop_icon release];
    [_shop_phone release];
    [_shopModel release];
    [_backView release];
}

@end
