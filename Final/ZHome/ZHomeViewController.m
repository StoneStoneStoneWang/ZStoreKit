//
//  ZHomeViewController.m
//  ZStoreTest
//
//  Created by three stone 王 on 2019/9/1.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZHomeViewController.h"

#if ZAppFormGlobalOne

@import SToolsKit;
@import LGSideMenuController;


@implementation ZHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar s_setBackgroundColor:[UIColor clearColor]];
}

- (void)configNaviItem {
    [super configNaviItem];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWith:[UIImage imageNamed:@"个人中心"] andTarget:self andSelector:@selector(openDrawer)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWith:[UIImage imageNamed:@"列表"] andTarget:self andSelector:@selector(showList)];
}

- (void)openDrawer {
    
    [self.sideMenuController showLeftViewAnimated];
    
}
- (void)showList {
    
    
}
@end

#endif
