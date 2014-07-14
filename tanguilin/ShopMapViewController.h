//
//  ShopMapViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-24.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//  //  有问题需要解答的，让加q群 170627662 ,我会尽我全力来回答问题，谢谢支持

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "ShopModel.h"
@interface ShopMapViewController : UIViewController<BMKMapViewDelegate,BMKAnnotation>{
    
    BMKMapView *_mapView;
    
}

@property (nonatomic,retain)ShopModel *shopModel;
@end
