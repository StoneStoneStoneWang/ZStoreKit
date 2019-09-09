//
//  ZReportViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZReportViewController.h"
#import "ZReportTableViewCell.h"
#import "ZReportHeaderView.h"
@import ZBridge;
#import "ZFragmentConfig.h"
@interface ZReportViewController ()

@end

@implementation ZReportViewController

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
#if ZAppFormGlobalOne
    
    [self.tableView registerClass:[ZReportTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.headerView = [[ZReportHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 120)];
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 100, CGRectGetHeight(self.view.bounds));
    
#endif
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZReportTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.reportBean = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [ZReportBridge new];
    
    [self.bridge createProfile:self];
}

- (void)configNaviItem {
    
    self.title = @"我的";
}
@end
