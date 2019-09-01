//
//  ZPravicyViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZPravicyViewController.h"
@import ZBridge;
@import SToolsKit;
@interface ZPravicyViewController ()

@property (nonatomic ,strong) ZPrivacyBridge *bridge;

@end

@implementation ZPravicyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if ZLoginFormOne
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor] ];
#elif ZLoginFormTwo
    
    
#else
    
    
#endif
}

- (void)configViewModel {
    
    self.bridge = [ZPrivacyBridge new];
    
    [self.bridge configViewModel:self];
}
- (void)configNaviItem {
    
    self.title = @"隐私与协议";
}

- (BOOL)canPanResponse {
    return true;
}

@end
