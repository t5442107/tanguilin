//
//  ShopInfoCommentModel.h
//  tanguilin
//
//  Created by yangyuji on 14-3-3.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "JSONModel.h"

@interface ShopInfoCommentModel : JSONModel

@property (nonatomic,copy) NSNumber * shop_gbid;
@property (nonatomic,copy) NSNumber * shopid;
@property (nonatomic,copy) NSNumber * shop_gb_posttime;
@property (nonatomic,copy) NSString *shop_gb_postdatetime;
@property (nonatomic,copy) NSNumber *shop_gb_authorid;
@property (nonatomic,copy) NSString *shop_gb_author;
@property (nonatomic,copy) NSString *shop_gb_content;
@property (nonatomic,copy) NSString <Optional> *icon;
@property (nonatomic,retain) NSNumber <Optional> *icon_w;
@property (nonatomic,retain) NSNumber <Optional> *icon_h;
@end
