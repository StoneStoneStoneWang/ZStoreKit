//
//  ZCircleViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZCircleViewController.h"
#import "ZCircleTableViewCell.h"
@import ZBridge;
@import SToolsKit;

@interface ZCircleViewController ()

@property (nonatomic ,strong) ZTListBridge *bridge;

@property (nonatomic ,assign) BOOL isMy;

@property (nonatomic ,strong) NSString *tag;

@end

@implementation ZCircleViewController

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
    
    [self.tableView registerClass:[ZCircleImageTableViewCell class] forCellReuseIdentifier:@"image"];
    
    
    [self.tableView registerClass:[ZCircleVideoTableViewCell class] forCellReuseIdentifier:@"video"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZCircleBean *circleBean = (ZCircleBean *)data;
    
    BOOL isVideo = false;
    
    for (ZKeyValueBean *keyValue in circleBean.contentMap) {
        
        if ([keyValue.type isEqualToString:@"video"]) {
            
            isVideo = true;
            
            break;
        }
    }
    
    if (isVideo) {
        
        ZCircleVideoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"video"];
        
        cell.circleBean = data;
        
        cell.bottomLineType = ZBottomLineTypeNormal;
        
        return cell;
    } else {
        
        ZCircleImageTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"image"];
        
        cell.circleBean = data;
        
        cell.bottomLineType = ZBottomLineTypeNormal;
        
        return cell;
    }
    
    
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 120;
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
- (BOOL)canPanResponse { return true; }

- (void)configNaviItem {
    
    if (self.isMy) {
        
        self.title = @"我的订单";
        
    } else {
        
        self.title = self.tag;
    }
}
@end

