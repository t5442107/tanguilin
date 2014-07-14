//
//  ShopAnnotation.m
//  tanguilin
//
//  Created by yangyuji on 14-2-24.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "ShopAnnotation.h"

@implementation ShopAnnotation


- (id)initWithShopModel:(ShopModel *)shopModel{
    self = [super init];
    if (self != nil) {
//        _shopModel = [shopModel retain];
        self.shopModel = shopModel;
        
    }
    return self;
}

- (NSString*)title{
    return @" ";
}
 

-(void)setShopModel:(ShopModel *)shopModel {
    if (_shopModel != shopModel) {
        [_shopModel release];
        _shopModel = [shopModel retain];
    }
    
    
    float  lat = [shopModel.shop_map_lat floatValue];
     float lng = [shopModel.shop_map_lng floatValue];
    if (lat > 0) {
        _coordinate = CLLocationCoordinate2DMake(lat, lng);
        
    }
    
    
    
    

}



- (void)dealloc
{
    NSLog(@" shopAnnotation dealloc");
    [super dealloc];
    [_shopModel release];
}
@end


