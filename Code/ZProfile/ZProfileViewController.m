//
//  ZProfileViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZProfileViewController.h"
#import "ZProfileTableViewCell.h"
#import "ZProfileTableHeaderView.h"
@import ZBridge;

@interface ZProfileViewController ()

@property (nonatomic ,strong) ZProfileBridge *bridge;

@property (nonatomic ,copy) ZProfileBlock block;

@end

@implementation ZProfileViewController

+ (instancetype)createProfileWithBlock:(ZProfileBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(ZProfileBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[ZProfileTableViewCell class] forCellReuseIdentifier:@"cell"];
    
#if ZContainDrawer
    
    self.headerView = [[ZProfileTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 100, 120)];
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 100, CGRectGetHeight(self.view.bounds));
#else
    
    self.headerView = [[ZProfileTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 100, 120)];
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 100, CGRectGetHeight(self.view.bounds));
#endif
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZProfileTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.profile = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [ZProfileBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createProfile:self profileAction:^(enum ZProfileActionType type, ZBaseViewController * _Nonnull vc) {
        
        weakSelf.block(type, vc);
    }];
}

- (void)configNaviItem {
    
    self.title = @"我的";
}

@end
