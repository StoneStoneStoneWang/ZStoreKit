//
//  ZTableListViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZTableListViewController.h"
#import "ZTableListTableViewCell.h"
@import ZBridge;
@import SToolsKit;
#if ZAppFormGlobalOne

@interface ZTableListViewController ()

@property (nonatomic ,strong) ZTListBridge *bridge;

@property (nonatomic ,assign) BOOL isMy;

@property (nonatomic ,strong) NSString *tag;

@end

@implementation ZTableListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    
}

+ (instancetype)createTableList:(BOOL )isMy andTag:(NSString *)tag {
    
    return [[self alloc] initWithTableList:isMy andTag:tag];
}

- (instancetype)initWithTableList:(BOOL )isMy andTag:(NSString *)tag {
    
    if (self = [super init]) {
        
        self.isMy = isMy;
        
        self.tag = tag;
    }
    return self;
}
- (void)configOwnSubViews {
    
    [self.tableView registerClass:[ZTableListTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZTableListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.keyValue = data;
    
    cell.bottomLineType = ZBottomLineTypeNormal;
    
    return cell;
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 160;
}

- (void)configViewModel {
    
    self.bridge = [ZTListBridge new];
    
    [self.bridge createTList:self isMy:self.isMy tag:self.tag];
    
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

#elif ZAppFormGlobalTwo

@interface ZTableListViewController ()

@property (nonatomic ,strong) ZTListBridge *bridge;

@property (nonatomic ,assign) BOOL isMy;

@property (nonatomic ,strong) NSString *tag;

@end

@implementation ZTableListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    
}

+ (instancetype)createTableList:(BOOL )isMy andTag:(NSString *)tag {
    
    return [[self alloc] initWithTableList:isMy andTag:tag];
}

- (instancetype)initWithTableList:(BOOL )isMy andTag:(NSString *)tag {
    
    if (self = [super init]) {
        
        self.isMy = isMy;
        
        self.tag = tag;
    }
    return self;
}
- (void)configOwnSubViews {
    
    [self.tableView registerClass:[ZTableListTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZTableListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.keyValue = data;
    
    cell.bottomLineType = ZBottomLineTypeNormal;
    
    return cell;
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 170;
}

- (void)configViewModel {
    
    self.bridge = [ZTListBridge new];
    
    [self.bridge createTList:self isMy:self.isMy tag:self.tag];
    
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



