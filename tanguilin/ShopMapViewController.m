//
//  ShopMapViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-2-24.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//  有什么问题 请到 加入QQ群 170627662 ，提问，我会尽力回答大家的

#import "ShopMapViewController.h" 

@implementation ShopMapViewController
@synthesize shopModel =_shopModel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_mapView ==nil) {
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 20 +44, ScreenWidth, ScreenHeight - 20 -44)];
        _mapView.delegate = self;
        [self.view addSubview:_mapView];
    
        
    }
    self.title = _shopModel.shop_name;
    
    
    CLLocationCoordinate2D  Location ;
    Location.latitude = [_shopModel.shop_map_lat floatValue];
    Location.longitude = [_shopModel.shop_map_lng floatValue];
    BMKCoordinateSpan span;
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    BMKCoordinateRegion Region = {Location,span};
    _mapView.showMapScaleBar = YES;
    [_mapView setRegion:Region animated:YES];
    
    
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
    annotation.title = _shopModel.shop_name;
    
     annotation.coordinate = CLLocationCoordinate2DMake( [_shopModel.shop_map_lat floatValue], [_shopModel.shop_map_lng floatValue]);
    [_mapView addAnnotation:annotation];
    [annotation release];
    
    
   
    
    
    
	 
}

- (BMKAnnotationView*)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        BMKPinAnnotationView * newAnnotation = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"cell"];
        newAnnotation.pinColor = BMKPinAnnotationColorGreen;
        newAnnotation.animatesDrop = YES;
        newAnnotation.canShowCallout = YES;
        
        return newAnnotation;
        
    }
    
    return nil;
}

#pragma mark 释放

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
   
    NSLog(@"_mapView.delegate = self");
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


 

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    NSLog(@"_mapView.delegate = nil");
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc
{
    [super dealloc];
    [_shopModel release];
    [_mapView release];
    
}


@end
