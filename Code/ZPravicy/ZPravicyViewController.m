//
//  ZPravicyViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZPravicyViewController.h"
@import ZBridge;

@interface ZPravicyViewController ()

@property (nonatomic ,strong) ZPrivacyBridge *bridge;

@end

@implementation ZPravicyViewController

- (void)configViewModel {
    
    self.bridge = [ZPrivacyBridge new];

    [self.bridge configViewModel:self];
    
//    [self loadReq:@"https://www.baidu.com"];
}
- (void)configNaviItem {
    
    self.title = @"隐私与协议";
}

@end
