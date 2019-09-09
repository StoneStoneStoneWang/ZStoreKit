//
//  ZGoldCleanerViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZGoldCleanerViewController.h"
#import "ZGoldCleanerTableViewCell.h"
#if ZAppFormGlobalOne

@import ZBridge;
@import SToolsKit;

@interface ZGoldCleanerViewController ()

@property (nonatomic ,strong) ZTListBridge *bridge;

@property (nonatomic ,assign) BOOL isMy;

@property (nonatomic ,strong) NSString *tag;

@end

@implementation ZGoldCleanerViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    
}

+ (instancetype)createGoldCleaner {
    
    return [self new];
}

- (void)configOwnSubViews {
    
    [self.tableView registerClass:[ZGoldCleanerTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZGoldCleanerTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
//    cell.keyValue = data;
    
    cell.bottomLineType = ZBottomLineTypeNormal;
    
    return cell;
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 5 + 25 + 20 + 20 + 15 + 40 + 5 + 5;
}
- (void)configViewModel {
    
    self.bridge = [ZTListBridge new];
    
    [self.bridge createTList:self isMy:false tag:self.tag];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)onReloadItemClick {
    [super onReloadItemClick];
    
    [self.tableView.mj_header beginRefreshing];
}
- (BOOL)canPanResponse {
    return true;
}
- (void)configNaviItem {
    
    self.title = @"我的订单";
}
@end

#endif



