//
//  ZAboutViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZAboutViewController.h"
#import "ZAboutTableViewCell.h"
#import "ZAboutTableHeaderView.h"
@import ZBridge;
@import ZNoti;

@interface ZAboutViewController ()

@property (nonatomic ,strong) ZAboutBridge *bridge;


@end

@implementation ZAboutViewController


- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[ZAboutTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.headerView = [[ZAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) / 2)];
    
    self.tableView.tableHeaderView = self.headerView;
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZAboutTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.about = data;
    
    cell.bottomLineType = ZBottomLineTypeNormal;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [ZAboutBridge new];
    
    [self.bridge createAbout:self];
}

- (void)configNaviItem {
    
    self.title = @"关于我们";
}

- (BOOL)canPanResponse {
    
    return true;
}
@end
