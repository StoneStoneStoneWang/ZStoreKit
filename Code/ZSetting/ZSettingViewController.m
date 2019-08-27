//
//  ZSettingViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZSettingViewController.h"
#import "ZSettingTableViewCell.h"
@import ZBridge;
@interface ZSettingViewController()

@property (nonatomic ,strong) ZSettingBridge *bridge;
@end

@implementation ZSettingViewController

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[ZSettingTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZSettingTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.setting = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [ZSettingBridge new];
    
    [self.bridge createSetting:self];
}

- (void)configNaviItem {
    
    self.title = @"设置";
}

@end
