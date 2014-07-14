//
//  MessageViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-2-17.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "MessageViewController.h" 
#import "JSONHTTPClient.h"
#import "ShopAnnotation.h"
#import "ShopAnnotationView.h"
#import "ShopInfoViewController.h"
#import "ShopListAVViewController.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"附近店家";
       
    }
    return self;
}





- (void)viewDidLoad
{
    
  [super viewDidLoad];
    
   
   
  
}

- (void)loadView{
    
    
    
    
    
    
    
    
    [super loadView];
    [self _initLoadMap];
}

- (void)_initLoadMap{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    float mapViewHeight = 0;
    if (WXHLOSVersion() >= 7) {
    mapViewHeight       = 20 +44;
    }

    if (_mapView ==nil) {
    _mapView            = [[BmapView alloc]initWithFrame:CGRectMake(0,mapViewHeight , ScreenWidth, ScreenHeight - 20 -44 -49)];

        [self.view addSubview:_mapView];

    }
    
    if (_userLocation == nil) {
    _userLocation              = [[BMKUserLocation alloc]init];
    }

    _userLocation.delegate     = self;
    [_userLocation startUserLocationService];


    UIBarButtonItem * shopList = [[UIBarButtonItem alloc]initWithTitle:@"列表浏览" style:UIBarButtonItemStylePlain target:self action:@selector(shoplistAction)];
    [self.navigationItem setRightBarButtonItem:shopList];
    [shopList release];
    
    
    
}

#pragma mark Action
-(void)shoplistAction{
    ShopListAVViewController *shopLAV = [[ShopListAVViewController alloc]init];
    shopLAV.data                      = _data;
    [self.navigationController pushViewController:shopLAV animated:YES];
    [shopLAV release];
}

/**
 *调用startUserLocationService定位成功后，会调用此函数
 *@param userLoc 我的位置坐标
 */
- (void)viewDidGetLocatingUser:(CLLocationCoordinate2D)userLoc{
    [self getLocation:userLoc.latitude longitude:userLoc.longitude];
    
    
    
    
}

 


 
// 得到定位数据后

- (void)getLocation:(float)latitude longitude:(float)longitude{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _latitude = latitude;
    _longitude = longitude;
    
    CLLocationCoordinate2D  Location ;
    Location.latitude = latitude;
    Location.longitude = longitude;
    BMKCoordinateSpan span;
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    BMKCoordinateRegion Region = {Location,span};
    _mapView.showMapScaleBar = YES;
    [_mapView setRegion:Region animated:YES];
     _mapView.showsUserLocation = YES;
    [_userLocation stopUserLocationService];
    
    if (_search == nil) {
        _search = [[BMKSearch alloc]init];
         _search.delegate = self;
    }
    
   
   
    if ([_search reverseGeocode:Location]) {
        NSLog(@"反编成功");
    }else{
        NSLog(@"反编失败");
    }
    
    
    
    
    
    
}
#pragma mark BMKAddrInfo delegate

- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error{
    NSNumber *latitudeNS = [NSNumber numberWithFloat:result.geoPt.latitude];
    NSNumber *longitudeNS = [NSNumber numberWithFloat:result.geoPt.longitude];
    NSNumber *catid = [NSNumber numberWithInt:1];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:latitudeNS ,@"latitude",longitudeNS,@"longitude",result.addressComponent.district,@"title",catid,@"catid", nil];
    
    
    [JSONHTTPClient getJSONFromURLWithString:LocationLists params:params completion:^(id json, JSONModelError *err) {
        if (_data == nil) {
            _data = [NSArray array];
        }
        _data = (NSArray *)json;
        [_data retain];
        [self getData];
    }];
    
    
}

#pragma mark data
- (void)getData{
    
    float mapViewHeight = 0;
    if (WXHLOSVersion() >= 7) {
        mapViewHeight = 20 +44;
    }
    
    UIView *msgView = [[UIView alloc]initWithFrame:CGRectMake(0, mapViewHeight, ScreenWidth, 20)];
    msgView.backgroundColor = [UIColor colorWithRed:0.863 green:0.773 blue:0.400 alpha:1];
    
    [self.view addSubview:msgView];
    [msgView release];
    
    UILabel *msgLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 250, 20)];
    msgLabel.text = [NSString stringWithFormat:@"你附近有 %d 家美食",_data.count];
    msgLabel.font = [UIFont systemFontOfSize:13.0f];
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.backgroundColor = [UIColor clearColor];
    [msgView addSubview:msgLabel];
    [msgLabel release];
    
    
    
    for (int i = 0 ; i< _data.count; i++) {
        
        NSDictionary *shopDic = [_data objectAtIndex:i];
        
        ShopModel *shopModel = [[ShopModel alloc]initWithDictionary:shopDic error:nil];
       
        ShopAnnotation *shopAnnotation = [[ShopAnnotation alloc]initWithShopModel:shopModel];
        
        [_mapView performSelector:@selector(addAnnotation:) withObject:shopAnnotation afterDelay:i * 0.05];
        
        [shopModel release];
        [shopAnnotation release];
        
    }
    
    
    
}

#pragma mark BMKAnnotationView delegate
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{ 
    
    static NSString *ide = @"shopAnnotationIde";
    
    ShopAnnotationView *shopAV = (ShopAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ide];
    if (shopAV == nil) {
        shopAV = [[[ShopAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ide]autorelease];
    }
    shopAV.canShowCallout = NO;
//    shopAV.frame = CGRectMake(0, 0, 180, 90);
    UIImage *images = [UIImage imageNamed:@"nearby_map_photo_bg"];
    shopAV.image = images;
    
    return shopAV;
}

/**
 *当mapView新添加annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 新添加的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    
    for (UIView *annotationView in views) {
        
        CGAffineTransform transform = annotationView.transform;
        annotationView.transform = CGAffineTransformScale(transform, 0.7, 0.7);
        annotationView.alpha = 0;
        
        [UIView animateWithDuration:0.5 animations:^{
            annotationView.transform = CGAffineTransformScale(transform, 1.7, 1.7);
            annotationView.alpha = 1;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.3 animations:^{
                annotationView.transform = CGAffineTransformIdentity;
            }];
        }];
    }
    

}

/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    
    if (![view isKindOfClass:[ShopAnnotationView class]]) {
        
        return;
    }
 
    
    ShopAnnotationView *views = (ShopAnnotationView*)view;
    ShopModel *shopMode =   (ShopModel*)views.shopModel;
    
    ShopInfoViewController *shopVC = [[ShopInfoViewController alloc]init];
    shopVC.shopMode = shopMode;
    [self.navigationController pushViewController:shopVC animated:YES];
    [shopVC release];
   
    
}


#pragma mark 释放

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    _search.delegate = self;
    
    NSLog(@"_mapView.delegate = self");
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _search.delegate = nil;
//    _Lsearch.delegate = nil;
    
    
     NSLog(@"_mapView.delegate = nil");
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
    NSLog(@"_mapView dealloc");
    [super dealloc];
    if (_mapView) {
        [_mapView release];
        _mapView = nil;
    }
       [_shopModel release];
        _shopModel = nil;
   
    
    [_data release];
    [_search release];
    
}


@end
