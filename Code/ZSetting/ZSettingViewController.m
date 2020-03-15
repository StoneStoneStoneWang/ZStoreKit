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
@import SToolsKit;

@interface ZSettingViewController()

@property (nonatomic ,strong) ZSettingBridge *bridge;

@property (nonatomic ,copy) ZSettingBlock block;
@end

@implementation ZSettingViewController

+ (instancetype)createSettingWithBlock:(ZSettingBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(ZSettingBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    
}

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
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createSetting:self settingAction:^(enum ZSettingActionType type, ZBaseViewController * _Nonnull vc) {
        
        weakSelf.block(type, vc);
    }];
}

- (void)configNaviItem {
    
    self.title = @"设置";
}
- (BOOL)canPanResponse {
    
    return true;
}

@end
