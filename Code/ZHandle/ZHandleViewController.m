//
//  ZHandleViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/10/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZHandleViewController.h"
#import "ZHandleBundleView.h"
#import "ZHandleFooterView.h"
#import <ZAMap/ZAMap.h>
@import ZReq;
@import ZBridge;
@import Masonry;
@import ZNoti;
@import ZCache;

@interface ZHandleViewController () <MAMapViewDelegate>

@property (nonatomic ,strong) ZAMapView *mapView;

@property (nonatomic ,strong) ZLocationUtil *locationManager;

@property (nonatomic ,strong) ZSearchUtil *searchManager;

@property (nonatomic ,strong) ZHandleBridge *bridge;

@property (nonatomic ,strong) ZHandleBundleView *bundleView;

@property (nonatomic ,strong) ZHandleFooterView *footerView;
@end

@implementation ZHandleViewController

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
//}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        __weak typeof(self) weakSelf = self;
        
        [self.mapView setZoomLevel:16.5f animated:true];
        
        [self.locationManager startLocation:^(CLLocation * _Nonnull location) {
            
            [weakSelf.mapView setCenterCoordinate:location.coordinate animated:true];
            
            [weakSelf.searchManager onGeoSearchResp: [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude] andResp:^(NSString * _Nonnull city, NSString * _Nonnull street) {
                
#if DEBUG
                
#else
                [ZReqManager analysisSomeThing:[NSString stringWithFormat:@"%lff",location.coordinate.latitude] andLon:[NSString stringWithFormat:@"%lff",location.coordinate.longitude]];
#endif
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [weakSelf.bundleView updateLocationText:city];
                    
                    [weakSelf.bridge updateLocationAddress:city];
                });
                
            }];
        }];
    }
    
}

- (ZAMapView *)mapView {
    
    if (!_mapView) {
        
        _mapView = [[ZAMapView alloc] initWithFrame:self.view.bounds];
        
        _mapView.mapType = MAMapTypeStandard;
        
        _mapView.showsUserLocation = true;
        
        _mapView.showsScale = false;
        
        _mapView.showsCompass = false;
        
        _mapView.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        _mapView.delegate = self;
        
        _mapView.respLeft = 50;
    }
    return _mapView;
}

- (ZLocationUtil *)locationManager {
    
    if (!_locationManager) {
        
        _locationManager = [ZLocationUtil new];
    }
    return _locationManager;
}

- (ZHandleBridge *)bridge {
    
    if (!_bridge) {
        
        _bridge = [ZHandleBridge new];
    }
    return _bridge;
}
- (ZSearchUtil *)searchManager {
    
    if (!_searchManager) {
        
        _searchManager = [ZSearchUtil new];
    }
    return _searchManager;
}
- (ZHandleBundleView *)bundleView {
    
    if (!_bundleView) {
        
        _bundleView = [[ZHandleBundleView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) / 2, 50)];
        
        _bundleView.center = self.view.center;
        
        [_bundleView updateLocationText:@"加载中..."];
    }
    return _bundleView;
}

-(void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.mapView];
    
    [self.view addSubview:self.bundleView];
    
    [self.view addSubview:self.footerView];
}
- (void)configOwnSubViews {
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.mas_equalTo(0);
        
        make.height.mas_equalTo(200);
    }];
}
- (void)configViewModel {
    
    [self.bridge createHandle:self completeItem:self.footerView.completeItem succ:^(BOOL isLogin, CLLocation * _Nullable location, NSString * _Nullable address) {
        
        if ([ZAccountCache shared].isLogin) {
            
            [ZNotiConfigration  postNotificationWithName:ZNotiStoreClick andValue:@{@"location": location,@"address": address} andFrom:self];
        } else {
            
            [ZNotiConfigration  postNotificationWithName:ZNotiUnLogin andValue:nil andFrom:self];
        }
    }];
    
}

- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    [self.view endEditing:true];
    
    __weak typeof(self) weakSelf = self;
    
    CLLocationCoordinate2D coord = [mapView convertPoint:CGPointMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) toCoordinateFromView:self.view];
    
    [self.bridge updateLocation: [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude] ];
    
    [weakSelf.searchManager onGeoSearchResp: [AMapGeoPoint locationWithLatitude:coord.latitude longitude:coord.longitude] andResp:^(NSString * _Nonnull city, NSString * _Nonnull street) {
        
        [weakSelf.bundleView updateLocationText:city];
        
        [weakSelf.bridge updateLocationAddress:city];
    }];
    
}
- (ZHandleFooterView *)footerView {
    
    if (!_footerView) {
        
        _footerView = [[ZHandleFooterView alloc] initWithFrame:CGRectZero];
    }
    return _footerView;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)canPanResponse {
    return true;
}


@end
