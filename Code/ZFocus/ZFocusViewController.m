//
//  ZFocusViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZFocusViewController.h"
#import "ZFocusTableViewCell.h"
@import ZBridge;
@interface ZFocusViewController ()

@property (nonatomic ,strong) ZFocusBridge *bridge;

@end

@implementation ZFocusViewController

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[ZFocusTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView.mj_header beginRefreshing];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZFocusTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.focus = data;
    
    return cell;
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 80;
}
- (void)configViewModel {
    
    self.bridge = [ZFocusBridge new];
    
    [self.bridge createFocus:self];
}

- (void)configNaviItem {
    
    self.title = @"我的关注";
}
- (BOOL)canPanResponse { return true; }

@end
