//
//  ZAMapViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZAMapViewController.h"
#import "ZAMapBunddleView.h"
#import "ZAMapHeaderView.h"
#import "ZAMapTableViewCell.h"
#import "ZFragmentConfig.h"
#import <ZAMap/ZAMap.h>
@import ZReq;
@import ZBridge;
@import ZNoti;
@import SToolsKit;
@import Masonry;
@import ZDatePicker;

@interface ZAMapViewController () <MAMapViewDelegate>

@property (nonatomic ,strong) ZAMapView *mapView;

@property (nonatomic ,strong) ZAMapBunddleView *bundleView;

@property (nonatomic ,strong) ZAMapBridge *bridge;

@property (nonatomic ,strong) ZLocationUtil *locationManager;

@property (nonatomic ,strong) ZSearchUtil *searchManager;

@property (nonatomic ,strong) UIView *footerView;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) MAPointAnnotation *shareAnnotation;

@property (nonatomic ,strong) UIImageView *shareAnnotationView;

@property (nonatomic ,assign) CLLocationCoordinate2D coor;

@property (nonatomic ,strong) ZDatePicker *picker;
@end

@implementation ZAMapViewController

- (ZAMapView *)mapView {
    
    if (!_mapView) {
        
        _mapView = [[ZAMapView alloc] initWithFrame:self.view.bounds];
        
        _mapView.mapType = MAMapTypeStandard;
        
        _mapView.showsUserLocation = true;
        
        _mapView.showsScale = false;
        
        _mapView.showsCompass = false;
        
        _mapView.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        _mapView.delegate = self;
    }
    return _mapView;
}
- (UIView *)footerView {
    
    if (!_footerView) {
        
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 60)];
        
        _footerView.backgroundColor = [UIColor whiteColor];
    }
    return _footerView;
}

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _completeItem.tag = 301;
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@ZFragmentColor] forState:UIControlStateNormal];
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@ZFragmentColor]] forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@ZCompleteItemTitle forState: UIControlStateNormal];
        
        [_completeItem setTitle:@ZCompleteItemTitle forState: UIControlStateHighlighted];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _completeItem.layer.cornerRadius = 24;
        
        _completeItem.layer.masksToBounds = true;
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _completeItem;
}

- (ZAMapBunddleView *)bundleView {
    
    if (!_bundleView) {
        
        _bundleView = [[ZAMapBunddleView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) / 2, 50)];
        
        _bundleView.center = self.view.center;
        
        [_bundleView updateLocationText:@"加载中..."];
    }
    return _bundleView;
}

- (ZLocationUtil *)locationManager {
    
    if (!_locationManager) {
        
        _locationManager = [ZLocationUtil new];
    }
    return _locationManager;
}

- (ZAMapBridge *)bridge {
    
    if (!_bridge) {
        
        _bridge = [ZAMapBridge new];
    }
    return _bridge;
}
- (ZSearchUtil *)searchManager {
    
    if (!_searchManager) {
        
        _searchManager = [ZSearchUtil new];
    }
    return _searchManager;
}
- (MAPointAnnotation *)shareAnnotation {
    
    if (!_shareAnnotation) {
        
        _shareAnnotation = [MAPointAnnotation new];
    }
    return _shareAnnotation;
}
- (UIImageView *)shareAnnotationView {
    
    if (!_shareAnnotationView) {
        
        _shareAnnotationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@ZAnnotationIcon]];
    }
    return _shareAnnotationView;
}
-(void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.mapView];
    
    [self.view addSubview:self.bundleView];
    
    [self.footerView addSubview:self.completeItem];
    
    self.tableView.bounces = false;
}
- (void)configOwnSubViews {
    
    CGFloat h = 44 * 4 + 100;
    
    if (self.tabBarController) {
        
        self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - h - KTABBAR_HEIGHT, CGRectGetWidth(self.view.bounds), h);
    } else {
        
        self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - h , CGRectGetWidth(self.view.bounds), h);
    }
    
    self.headerView =  [[ZAMapHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40)];
    
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerClass:[ZAMapTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = self.footerView;
    
    __weak typeof(self) weakSelf = self;
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(48);
        
        make.centerY.equalTo(self.footerView);
    }];
    
    switch (self.locationManager.authStatus) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            
        {
            [self.mapView addAnnotation:self.shareAnnotation];
            
            [self.shareAnnotationView sizeToFit];
            
            self.shareAnnotationView.center = self.view.center;
            
            [self.mapView setZoomLevel:16.5f animated:true];
            
            [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:true];
            
            [self.locationManager startLocation:^(CLLocation * _Nonnull location) {
                
                weakSelf.coor = location.coordinate;
                
                [weakSelf.bridge updateLocation:location];
                
                [weakSelf.searchManager onGeoSearchResp: [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude] andResp:^(NSString * _Nonnull city, NSString * _Nonnull street) {
                    
#if DEBUG
                    
#else
                    [ZReqManager analysisSomeThing:[NSString stringWithFormat:@"%lff",location.coordinate.latitude] andLon:[NSString stringWithFormat:@"%lff",location.coordinate.longitude]];
#endif
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [((ZAMapHeaderView *)weakSelf.headerView) updateLocationText:city];
                        
                        [weakSelf.bundleView updateLocationText:city];
                    });
                    
                }];
            }];
        }
            break;
            
        default:
            
        {
            [self addObserver:self forKeyPath:@"locationManager.authStatus" options:(NSKeyValueObservingOptionNew) context:nil];
        }
            
            break;
    }
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    [self addObserver:self forKeyPath:@"locationManager.authStatus" options:(NSKeyValueObservingOptionNew) context:nil];
    if ([keyPath isEqualToString:@"locationManager.authStatus"]) {
        
        NSLog(@"%@",change);
        
        [self.mapView addAnnotation:self.shareAnnotation];
        
        [self.shareAnnotationView sizeToFit];
        
        self.shareAnnotationView.center = self.view.center;
        
        [self.mapView setZoomLevel:16.5f animated:true];
        
        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:true];
        
        __weak typeof(self) weakSelf = self;
        
        [self.locationManager startLocation:^(CLLocation * _Nonnull location) {
            
            weakSelf.coor = location.coordinate;
            
            [weakSelf.bridge updateLocation:location];
            
            [weakSelf.searchManager onGeoSearchResp: [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude] andResp:^(NSString * _Nonnull city, NSString * _Nonnull street) {
                
#if DEBUG
                
#else
                [ZReqManager analysisSomeThing:[NSString stringWithFormat:@"%lff",location.coordinate.latitude] andLon:[NSString stringWithFormat:@"%lff",location.coordinate.longitude]];
#endif
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [((ZAMapHeaderView *)weakSelf.headerView) updateLocationText:city];
                    
                    [weakSelf.bundleView updateLocationText:city];
                });
                
            }];
        }];
    }
}
- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZKeyValueBean *keyValue = (ZKeyValueBean *)data;
    
    if ([keyValue.type containsString:@"时间"]) {
        
        if (!self.picker) {
            
            self.picker = [[ZDatePicker alloc] initWithTextColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] buttonColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor] font:[UIFont systemFontOfSize:15] locale:[NSLocale localeWithLocaleIdentifier:@"zh-Hans"] showCancelButton:true];
        }
        
        __weak typeof(self) weakSelf = self;
        
        [self.picker show:@"" doneButtonTitle:@"完成" cancelButtonTitle:@"取消" defaultDate:[NSDate date] minimumDate:[NSDate date] maximumDate:nil datePickerMode:UIDatePickerModeDate callback:^(NSDate * _Nullable date) {
            
            if (date) {
                
                NSDateFormatter *df = [NSDateFormatter new];
                
                df.dateFormat = @"yyyy-MM-dd HH:mm";
                
                keyValue.value = [df stringFromDate:date];
                
                [weakSelf.tableView reloadData];
            }
        }];
        
    }
}

- (void)setCoor:(CLLocationCoordinate2D)coor {
    
    [self.mapView setCenterCoordinate:coor animated:true];
    
}
- (void)configNaviItem {
    
}
- (void)configViewModel {
    
#if ZAppFormGlobalOne
    
    [self.bridge createUserInfo:self forms:ZKeyValues tag:@"" succ:^{
        
        
    }];
    
#elif ZAppFormMapTwo
    
    
#endif
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZAMapTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.keyValue = data;
    
    cell.bottomLineType = ZBottomLineTypeNormal;
    
    return cell;
}

- (void)keyboardWillShow:(NSNotification *)noti {
    
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat h = 44 * 4 + 100;
    
    [UIView animateWithDuration:duration animations:^{
        
        if (self.tabBarController) {
            
            self.tableView.frame = CGRectMake(0, frame.origin.y - h - KTABBAR_HEIGHT , CGRectGetWidth(self.view.bounds), h);
        } else {
            
            self.tableView.frame = CGRectMake(0, frame.origin.y - h , CGRectGetWidth(self.view.bounds), h);
        }
        
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)keyboardWillHide:(NSNotification *)noti {
    
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat h = 44 * 4 + 100;
    
    [UIView animateWithDuration:duration animations:^{
        
        if (self.tabBarController) {
            
            self.tableView.frame = CGRectMake(0, frame.origin.y - h - KTABBAR_HEIGHT , CGRectGetWidth(self.view.bounds), h);
        } else {
            
            self.tableView.frame = CGRectMake(0, frame.origin.y - h , CGRectGetWidth(self.view.bounds), h);
        }
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    
}
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    [self.view endEditing:true];
    
    __weak typeof(self) weakSelf = self;
    
    CLLocationCoordinate2D coord = [mapView convertPoint:CGPointMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) toCoordinateFromView:self.view];
    
    [self.bridge updateLocation: [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude] ];
    
    [weakSelf.searchManager onGeoSearchResp: [AMapGeoPoint locationWithLatitude:coord.latitude longitude:coord.longitude] andResp:^(NSString * _Nonnull city, NSString * _Nonnull street) {
        
        [((ZAMapHeaderView *)weakSelf.headerView) updateLocationText:city];
        
        [weakSelf.bundleView updateLocationText:city];
    }];
}
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    MAAnnotationView *userLocalView = views.firstObject;
    
    if (userLocalView) {
        
        userLocalView.canShowCallout = true;
        
        if ([userLocalView isKindOfClass:[MAUserLocation class]]) {
            
            MAUserLocationRepresentation *rep = [[MAUserLocationRepresentation alloc] init];
            
            rep.image = [UIImage imageNamed:@ZLightCircle];
            
            rep.showsAccuracyRing = true;
            
            [mapView updateUserLocationRepresentation:rep ];
            
        } else {
            
            userLocalView.image = nil;
            
            [mapView selectAnnotation:self.shareAnnotation animated:true];
            
        }
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)canPanResponse {
    return true;
}

@end

