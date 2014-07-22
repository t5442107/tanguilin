//
//  ShopMapViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-24.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "ShopModel.h"
@interface ShopMapViewController : UIViewController<BMKMapViewDelegate,BMKAnnotation>{
    
    BMKMapView *_mapView;
    
}

@property (nonatomic,retain)ShopModel *shopModel;
@end
