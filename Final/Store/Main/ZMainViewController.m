//
//  ZMainViewController.m
//  ZStoreTest2
//
//  Created by three stone 王 on 2019/9/12.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZMainViewController.h"

#if ZAppFormGlobalTwo
@import ZGoldCleaner;
@import ZProfile;
#import "ZHomeViewController.h"

@implementation ZMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZHomeViewController *home = [ZHomeViewController new];
    
    [self addChildViewController:home andTitle:@"首页" andNormalColor:@"#999999" andSelectedColor:@ZFragmentColor andNormalImage:@"首页未" andSelectImage:@"首页选"];
    
    ZGoldCleanerViewController *goldCleaner = [ZGoldCleanerViewController createGoldCleaner];
    
    [self addChildViewController:goldCleaner andTitle:@"金牌保洁" andNormalColor:@"#999999" andSelectedColor:@ZFragmentColor andNormalImage:@"订单未" andSelectImage:@"订单选"];
    
    ZProfileViewController *profile = [ZProfileViewController new];
    
    [self addChildViewController:profile andTitle:@"我的" andNormalColor:@"#999999" andSelectedColor:@ZFragmentColor andNormalImage:@"个人中心未" andSelectImage:@"个人中心选"];
}
@end

#endif
