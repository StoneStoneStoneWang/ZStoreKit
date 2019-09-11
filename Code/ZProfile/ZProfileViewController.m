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
@end

@implementation ZProfileViewController

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[ZProfileTableViewCell class] forCellReuseIdentifier:@"cell"];
    
#if ZAppFormGlobalOne
    
    self.headerView = [[ZProfileTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 100, 100)];
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 100, CGRectGetHeight(self.view.bounds));
    
#elif ZAppFormGlobalTwo
    
    self.headerView = [[ZProfileTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    
#endif
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZProfileTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.profile = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [ZProfileBridge new];
    
    [self.bridge createProfile:self];
}

- (void)configNaviItem {
    
    self.title = @"我的";
}

@end
