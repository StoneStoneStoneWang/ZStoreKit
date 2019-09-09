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
@import JXTAlertManager;
@import ZNoti;
@import ZBridge;
@import SToolsKit;

@interface ZGoldCleanerViewController ()

@property (nonatomic ,strong) ZTListBridge *bridge;

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
    
    cell.keyValue = data;
    
    cell.bottomLineType = ZBottomLineTypeNormal;
    
    return cell;
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 70;
}
- (void)configViewModel {
    
    self.bridge = [ZTListBridge new];
    
    [self.bridge createTList:self isMy:false tag:@""];
    
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
    
    self.title = @"金牌保洁";
}

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    [self jxt_showActionSheetWithTitle:@"操作" message:@"" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDefaultTitle(@"举报").
        addActionDefaultTitle(@"拨打电话");
        
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        
        if ([action.title isEqualToString:@"取消"]) {
            
        }
        else if ([action.title isEqualToString:@"举报"]) {
            
            [ZNotiConfigration postNotificationWithName:ZNotiCircleGotoReport andValue:data andFrom:self];
            
        } else if ([action.title isEqualToString:@"拨打电话"]) {
            
            ZCircleBean *circle = (ZCircleBean *)data;
            
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[circle.contentMap.firstObject.value componentsSeparatedByString:@":"].lastObject];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }];
}
@end

#endif



