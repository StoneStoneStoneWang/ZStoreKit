//
//  ZBlackViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZBlackViewController.h"
#import "ZBlackTableViewCell.h"
@import ZActionBridge;
@interface ZBlackViewController ()

@property (nonatomic ,strong) ZBlackBridge *bridge;
@end

@implementation ZBlackViewController

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[ZBlackTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView.mj_header beginRefreshing];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZBlackTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.black = data;
    
    return cell;
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 80;
}
- (void)configViewModel {
    
    self.bridge = [ZBlackBridge new];
    
    [self.bridge createBlack:self];
}

- (void)configNaviItem {
    
    self.title = @"黑名单";
}

- (BOOL)canPanResponse {
    
    return true;
}

@end
