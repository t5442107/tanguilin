//
//  ShopMapViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-24.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//  有什么问题 请到 加入QQ群 170627662 ，提问，我会尽力回答大家的

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "ShopModel.h"
@interface ShopMapViewController : UIViewController<BMKMapViewDelegate,BMKAnnotation>{
    
    BMKMapView *_mapView;
    
}

@property (nonatomic,retain)ShopModel *shopModel;
@end
