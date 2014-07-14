//
//  ShopAnnotationView.h
//  tanguilin
//
//  Created by yangyuji on 14-2-24.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "BMKAnnotationView.h"
#import "ShopModel.h"
@interface ShopAnnotationView : BMKAnnotationView{
    UIImageView *_shop_icon;
    UILabel *_shop_name;
    UILabel *_shop_phone;
    UILabel *_shop_address;
    UIView *_backView;
}

@property (nonatomic,retain)ShopModel *shopModel;

@end
