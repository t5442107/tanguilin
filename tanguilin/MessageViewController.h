//
//  MessageViewController.h
//  tanguilin
//
//  Created by yangyuji on 14-2-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BmapView.h"
#import "BMKUserLocation.h"
#import "ShopModel.h"
#import "BMKSearch.h"  
@interface MessageViewController : UIViewController <BMKMapViewDelegate,BMKUserLocationDelegate,BMKSearchDelegate>
{
    BmapView *_mapView;
    BMKUserLocation *_userLocation;
    float _latitude;
    float _longitude;
    NSArray *_data; 
    
}

@property (nonatomic ,assign) BOOL      isOpenShopInfo;
@property (nonatomic,retain ) ShopModel *shopModel;
@property (nonatomic,retain ) BMKSearch * search;


@end
