//
//  ShopAnnotation.h
//  tanguilin
//
//  Created by yangyuji on 14-2-24.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKAnnotation.h"
#import "ShopModel.h"
@interface ShopAnnotation : NSObject <BMKAnnotation>

///标注view中心坐标.
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic,retain)ShopModel *shopModel;


- (id)initWithShopModel:(ShopModel *)shopModel;
 
@end
